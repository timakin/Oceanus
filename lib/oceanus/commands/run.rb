module Oceanus
    module Commands
        # コンテナを作成するクラス
        class Run
            def self.exec(image, path)
                puts "Running image...#{image}"
            end
        end
    end
end
