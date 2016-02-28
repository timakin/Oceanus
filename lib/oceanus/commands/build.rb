require 'oceanus/utils/parser'
require 'lxc'

module Oceanus
    module Commands
        # Dockerfileからimageを作成するクラス
        class Build
            # TODO: ビルドファイルに差分があるかチェックする
            # TODO: entrypointのコマンドを保存しておいて、起動時に実行する
            def self.exec(path)
                cmds = Oceanus::Utils::Parser.get_input_commands(path)

                # get Image with `FROM` tag
                image, tag = cmds["FROM"].split("")
                api = Oceanus::Utils::Image.new(image, tag)
                api.get_image

                # TODO: not uuid, use short id or name
                c = LXC::Container.new(uuidgen)
                c.create(image)
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
                        # TODO: rootfs
                        FileUtils.cp_rf(src, rootfs + dest)
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
