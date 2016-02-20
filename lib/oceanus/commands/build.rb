module Oceanus
    module Commands
        # Dockerfileからimageを作成するクラス
        class Build
            def self.exec(image, path)
                puts "build installed #{image} with #{path}/Dockerfile"
            end
        end
    end
end
