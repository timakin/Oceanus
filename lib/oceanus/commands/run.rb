require 'lxc'

module Oceanus
    module Commands
        # コンテナを作成するクラス
        class Run
            def self.exec(image, *args)
                c = LXC::Container.new(uuidgen)
                # TODO: image name => template_path
                # TODO: backingstore => btrfs
                c.create(image)
                c.start
                c.attach do
                    LXC.run_command(args)
                end
                puts "Running image...#{image}"
            end
        end
    end
end
