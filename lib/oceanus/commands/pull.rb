require 'oceanus/utils/api'

module Oceanus
    module Commands
        # Docker Hubからimageを取得する
        class Pull
            def self.exec(image)
                # http://docs.docker.com/v1.7/reference/api/hub_registry_spec/#pull
                api = Oceanus::Utils::API.new('timakin/node-mongo-codemagnet')
                api.get_images
                puts "pull #{image}"
            end
        end
    end
end
