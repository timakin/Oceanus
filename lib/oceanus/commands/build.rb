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

                # TODO: image rootfs path
                c = LXC::Container.new(SecureRandom.hex(10))
                c.create(rootfs + image_manaber.image)
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
