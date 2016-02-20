module Oceanus
    module Commands
        # コンテナ、imageを削除するクラス
        class Remove
            def self.image(image, path)
                puts "Removing image...#{image}"
            end

            def self.container(container, path)
                puts "Removin container..."
            end
        end
    end
end
