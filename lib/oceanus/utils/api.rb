require 'httpclient'

module Oceanus
    module Utils
        class API
            def initialize(image, tag='latest')
                @client = HTTPClient.new()
                @index_path = "https://index.docker.io/v1"
                @registry_path = "https://registry-1.docker.io/v1"
                @image_path = "#{@index_path}/repositories/#{image}/images"
                @latest_tag_path = "#{@registry_path}/repositories/#{image}/tags/#{tag}"
            end

            def get_access_token
                res = @client.get(@image_path, nil, {'X-Docker-Token' => true})
                @access_token = res.header["X-Docker-Token"]
            end

            def get_latest_tag
                res = @client.get(@latest_tag_path, nil, {'Authorization' => "Token #{@access_token.join(", ")}"})
                @latest_tag = res.body
            end
        end
    end
end
