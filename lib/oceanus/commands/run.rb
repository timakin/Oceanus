require 'lxc'
require 'oceanus/utils/file_system'

module Oceanus
    module Commands
        # コンテナを作成するクラス
        class Run
            def self.exec(image, *args)
                c = LXC::Container.new(SecureRandom.hex(10))
                # TODO: image name => rootfs
                # TODO: template: none
                c.create(fs.saving_path + image, "-B", "btrfs")
                c.start
                c.attach do
                    LXC.run_command(args)
                end
                puts "Running image...#{image}"
            end
        end
    end
end
