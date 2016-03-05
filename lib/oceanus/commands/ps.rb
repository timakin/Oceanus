require 'lxc'

module Oceanus
    module Commands
        # 起動中のコンテナの一覧を表示する
        class ProcessStatus
            def self.exec
                container_ids = Dir.glob("/var/lib/lxc/**/")
                               .select{ |dir| dir.split("/").size == 5 }
                               .each{ |dir| dir.slice!("#{fs.saving_path}/") }
                               .each{ |dir| dir.slice!("/") }
                for id in container_ids
                    c = LXC::Container.new(id)
                    c.state()
                end
            end
        end
    end
end
