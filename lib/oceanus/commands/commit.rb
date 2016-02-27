module Oceanus
    module Commands
        # コンテナからimageを作成する
        class Commit
            def self.exec
                # container から snapshot作成
                puts "Create a new image from a container's changes"
            end
        end
    end
end
