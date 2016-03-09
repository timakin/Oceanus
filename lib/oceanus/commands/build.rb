require 'oceanus/utils/parser'
require 'lxc'
require 'digest/md5'

module Oceanus
    module Commands
        # Dockerfileからimageを作成するクラス
        class Build

            def self.exec(path)
                fs = Oceanus::Utils::FileSystem.new()
                cmds = Oceanus::Utils::Parser.get_input_commands(path)
                # get Image with `FROM` tag
                image, tag = cmds["FROM"].split("")
                image_manager = Oceanus::Utils::Image.new(image, tag)
                image_manager.get_image

                generate_record(fs.saving_path, image_manager.uuid)

                c = LXC::Container.new(SecureRandom.hex(10))
                c.create("-t", "none", "-B", "dir", "--dir", fs.saving_path + image_manager.uuid)
                c.start
                cmds["RUN"].each do |run_cmd|
                    c.attach do
                        LXC.run_command(run_cmd.join(" "))
                    end
                end

                cmds["ADD"].each do |cmd|
                    if (cmd.length > 1)
                        src = cmd[0]
                        dest = cmd[1]
                        FileUtils.cp_rf(src, fs.saving_path + dest)
                    end
                end

                cmds["CMD"].each do |cmd|
                    c.attach do
                        LXC.run_command(run_cmd.join(" "))
                    end
                end
            end

            def generate_record(saving_path, uuid)
                cmd_file_path = saving_path + uuid + "/.executed_cmds"
                if File.exists?(cmd_file_path)
                    FileUtils.touch(cmd_file_path)
                    File.open(cmd_file_path, 'w') { |f| f.write("[]") }
                end
            end

            def record_cmd(saving_path, uuid, cmd)
                # すでに実行したコマンドをファイルに書き出しておいて、再実行を防ぐ。
                # md5ハッシュ値が存在しなかったら実行する
                cmd_file_path = saving_path + uuid + "/.executed_cmds"
                File.open(cmd_file_path, 'w') do |f|
                    record = JSON.parse(f)
                    digest = Digest::MD5.hexdigest(cmd)
                    unless record.includes?(digest)
                        record << digest
                    end
                    json = JSON.generate(record)
                    f.write(json)
                end
            end
        end
    end
end
