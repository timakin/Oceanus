require 'lxc'

module Oceanus
    module Commands
        # 起動中のコンテナの一覧を表示する
        class ProcessStatus
            def self.exec
                c = LXC::Container.new()
                # TODO: たぶん間違ってる
                c.state("*")
            end
        end
    end
end
