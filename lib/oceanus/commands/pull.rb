require 'oceanus/utils/api'

module Oceanus
    module Commands
        class Pull
            def self.exec(image)
                # http://docs.docker.com/v1.7/reference/api/hub_registry_spec/#pull
                api = Oceanus::Utils::API.new
                access_token = api.get_access_token('timakin/node-mongo-codemagnet')
                puts access_token
                puts "pull #{image}"
            end
        end
    end
end
