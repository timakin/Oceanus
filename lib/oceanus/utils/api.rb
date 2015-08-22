require 'httpclient'

module Oceanus
    module Utils
        class API
            def initialize
                @client = HTTPClient.new()
                @docker_hub_repository_path = "https://index.docker.io/v1/repositories"
            end

            def get_access_token(image)
                @image_path = "#{@docker_hub_repository_path}/#{image}/images"
                res = @client.get(@image_path, nil, {'X-Docker-Token' => true})
                @access_token = res.header["X-Docker-Token"]
            end
        end
    end
end
