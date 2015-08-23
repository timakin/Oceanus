require 'httpclient'
require 'fileutils'

module Oceanus
    module Utils
        class API
            def initialize(image, tag='latest')
                @client          = HTTPClient.new()
                @index_path      = "https://index.docker.io/v1"
                @registry_path   = "https://registry-1.docker.io/v1"
                @image_path      = "#{@index_path}/repositories/#{image}/images"
                @latest_tag_path = "#{@registry_path}/repositories/#{image}/tags/#{tag}"
            end

            def get_images
                get_access_token
                get_latest_tag
                get_ancestry
                get_layers
            end

            private
            def get_access_token
                res = @client.get(@image_path, nil, {'X-Docker-Token' => true})
                @access_token = res.header["X-Docker-Token"].join(", ")
            end

            def get_latest_tag
                res = @client.get(@latest_tag_path, nil, {'Authorization' => "Token #{@access_token}"})
                @latest_tag = res.body.gsub(/"/, "")
            end

            def get_ancestry
                ancestry_path = "#{@registry_path}/images/#{@latest_tag}/ancestry"
                res = @client.get(ancestry_path, nil, {'Authorization' => "Token #{@access_token}"})
                @ancestry = res.body.gsub(/\[|\]|"/, "").split(", ")
            end

            def get_layers
                uuid = SecureRandom.uuid
                puts uuid
                Dir.mkdir("/tmp/#{uuid}")
                puts "Downloading images..."
                begin
                    @ancestry[3..4].map { |id|
                        layer_path       = "#{@registry_path}/images/#{id}/layer"
                        gateway_res      = @client.get(layer_path, nil, {'Authorization' => "Token #{@access_token}"})
                        compressed_image = @client.get(gateway_res.header['Location'][0], nil, {'Authorization' => "Token #{@access_token}"})
    
                        File.open("/tmp/#{uuid}/layer.tar", 'a') do |file|
                            file.write(compressed_image_res.body)
                            file.close()
                        end
                    }
                rescue => e
                    puts e.message
                    FileUtils.rm_r("/tmp/#{uuid}")
                end
            end
        end
    end
end
