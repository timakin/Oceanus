require 'oceanus/utils/api'

module Oceanus
    module Commands
        class Pull
            def self.exec(image)
                # http://docs.docker.com/v1.7/reference/api/hub_registry_spec/#pull
                api = Oceanus::Utils::API.new('timakin/node-mongo-codemagnet')
                access_token = api.get_access_token
                puts access_token
                tag = api.get_latest_tag
                puts tag
                puts "pull #{image}"
            end
        end
    end
end
