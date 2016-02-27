require 'lxc'

module Oceanus
    module Commands
        # コンテナを停止する
        class Stop
            def self.exec(image)
                # TODO: image_name => template
                c = LXC::Container.new(image)
                c.stop
                puts "Stopped: #{c.name}"
            end
        end
    end
end
