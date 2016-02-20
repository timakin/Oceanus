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

            # Docker Registry APIを叩くために必要なアクセストークンを取得する
            def get_access_token
                res = @client.get(@image_path, nil, {'X-Docker-Token' => true})
                @access_token = res.header["X-Docker-Token"].join(", ")
            end

            # imageの最新版のtagを取得する
            def get_latest_tag
                res = @client.get(@latest_tag_path, nil, {'Authorization' => "Token #{@access_token}"})
                @latest_tag = res.body.gsub(/"/, "")
            end

            # Imageのancestry(diff履歴)を取得する
            def get_ancestry
                ancestry_path = "#{@registry_path}/images/#{@latest_tag}/ancestry"
                res = @client.get(ancestry_path, nil, {'Authorization' => "Token #{@access_token}"})
                @ancestry = res.body.gsub(/\[|\]|"/, "").split(", ")
            end

            # layer(Imageのバイナリデータ)を取得し、特定ディレクトリ配下に展開する
            def get_layers
                uuid = SecureRandom.uuid
                puts uuid
                Dir.mkdir("/tmp/#{uuid}")
                puts "Downloading images..."
                begin
                    ## 個別のimageデータを取得し、tarファイルとして保存。
                    @ancestry[3..4].map { |id|
                        layer_path       = "#{@registry_path}/images/#{id}/layer"
                        gateway_res      = @client.get(layer_path, nil, {'Authorization' => "Token #{@access_token}"})
                        compressed_image = @client.get(gateway_res.header['Location'][0], nil, {'Authorization' => "Token #{@access_token}"})

                        File.open("/tmp/#{uuid}/layer.tar", 'a') do |file|
                            file.write(compressed_image.body)
                            file.close()
                        end
                    }

                    ## 一時的にlayer.tarとして保存したimageを特定ディレクトリに展開する。
                    ## 展開し終わったらlayer.tarは削除する。

                    ## img.sourceという、{image}:{tag}のペアを記録したファイルを作る。

                    ## 展開したファイルシステムを/var/oceanous以下にコピー、
                rescue => e
                    puts e.message
                    FileUtils.rm_r("/tmp/#{uuid}")
                end
            end
        end
    end
end
