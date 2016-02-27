require 'lxc'

module Oceanus
    module Commands
        # コンテナを作成するクラス
        class Run
            def self.exec(image, *args)
                c = LXC::Container.new(uuidgen)
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
