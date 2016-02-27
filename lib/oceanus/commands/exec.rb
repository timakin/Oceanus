require 'lxc'

module Oceanus
    module Commands
        # コンテナ内でコマンドを実行するためのクラス
        class Exec
            def self.exec(container, *args)
                c = LXC::Container.new(container)
                c.attach do
                    LXC.run_command(args)
                end
                puts "Run a command in an existing container"
            end
        end
    end
end
