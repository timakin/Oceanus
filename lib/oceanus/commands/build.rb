module Oceanus
    module Commands
        class Build
            def self.exec(image, path)
                puts "build installed #{image} with #{path}/Dockerfile"
            end
        end
    end
end
