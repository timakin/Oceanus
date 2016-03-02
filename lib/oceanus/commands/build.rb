require 'oceanus/utils/parser'
require 'lxc'

module Oceanus
    module Commands
        # Dockerfileからimageを作成するクラス
        class Build
            def self.exec(path)
                cmds = Oceanus::Utils::Parser.get_input_commands(path)

                # get Image with `FROM` tag
                image, tag = cmds["FROM"].split("")
                image_manager = Oceanus::Utils::Image.new(image, tag)
                image_manager.get_image

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
        end
    end
end
