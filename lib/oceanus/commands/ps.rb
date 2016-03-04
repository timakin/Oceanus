require 'lxc'

module Oceanus
    module Commands
        # 起動中のコンテナの一覧を表示する
        class ProcessStatus
            def self.exec
                container_ids = Dir.glob("/var/lib/lxc/**/")
                               .map{ |dir| dir.split("/").size == 1 }
                               .each{ |dir| dir.slice!("#{fs.saving_path}/") }
                for id in container_ids
                end

c = LXC::Container.new()
                # TODO: たぶん間違ってる
                c.state()
            end
        end
    end
end
