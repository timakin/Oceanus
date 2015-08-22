module Oceanus
    module Commands
        class Pull
            def self.exec(image)
                # http://docs.docker.com/v1.7/reference/api/hub_registry_spec/#pull
                puts "pull #{image}"
            end
        end
    end
end
