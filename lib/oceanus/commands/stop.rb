require 'lxc'

module Oceanus
    module Commands
        # コンテナを停止する
        class Stop
            def self.exec(container)
                c = LXC::Container.new(container)
                c.stop
                puts "Stopped: #{c.name}"
            end
        end
    end
end
