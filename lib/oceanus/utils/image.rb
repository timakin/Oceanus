require 'httpclient'
require 'fileutils'
require 'oceanus/utils/file_system'

module Oceanus
    module Utils
        class Image
            def initialize(image, tag='latest')
                @client          = HTTPClient.new()
                @index_path      = "https://index.docker.io/v1"
                @registry_path   = "https://registry-1.docker.io/v1"
                @image_path      = "#{@index_path}/repositories/#{image}/images"
                @tag_path = "#{@registry_path}/repositories/#{image}/tags/#{tag}"
                @image = image
                @tag   = tag
                @uuid  = SecureRandom.uuid
            end

            def get_image
                get_access_token
                get_image_id
                get_ancestry
                get_layers
                create_image_volume
            end

            class << self
                def get_image_source_mapping
                    img_source_paths = Dir.glob("#{fs.saving_path}/**/img.source")
                    if img_source_paths.empty?
                        return {}
                    end
                    image_ids = Dir.glob("#{fs.saving_path}/**/")
                                   .map{ |dir| dir.split("/").size == 1 }
                                   .each{ |dir| dir.slice!("#{fs.saving_path}/") }
                    mapping = Hash.new
                    for id in image_ids
                        img_source_path = img_source_paths.select{ |p| p.split("/")[1] == id }.first
                        img_source = File.open(img_source_path).read
                        mapping.store(id, img_source)
                    end
                    mapping
                end
            end


            private

            # Docker Registry APIを叩くために必要なアクセストークンを取得する
            def get_access_token
                res = @client.get(@image_path, nil, {'X-Docker-Token' => true})
                @access_token = res.header["X-Docker-Token"].join(", ")
            end

            # Get image id for a particular tag
            def get_image_id
                res = @client.get(@tag_path, nil, {'Authorization' => "Token #{@access_token}"})
                @image_id = res.body.gsub(/"/, "")
            end

            # Imageのancestry(diff履歴)を取得する
            def get_ancestry
                ancestry_path = "#{@registry_path}/images/#{@image_id}/ancestry"
                res = @client.get(ancestry_path, nil, {'Authorization' => "Token #{@access_token}"})
                @ancestry = res.body.gsub(/\[|\]|"/, "").split(", ")
            end

            # layer(Imageのバイナリデータ)を取得し、特定ディレクトリ配下に展開する
            # ストレージの状態の差分(ancestry)をレイヤとして重ね合わせることで、イメージを形成する。（ユニオンファイルシステム）
            def get_layers
                # TODO: 本当にuuidでいいのか
                Dir.mkdir("/tmp/#{@uuid}")
                puts "Downloading an image..."
                begin
                    ## 個別のimageデータを取得し、tarファイルとして保存。
                    @ancestry.map { |id|
                        layer_path       = "#{@registry_path}/images/#{id}/layer"
                        gateway_res      = @client.get(layer_path, nil, {'Authorization' => "Token #{@access_token}"})
                        compressed_image = @client.get(gateway_res.header['Location'][0], nil, {'Authorization' => "Token #{@access_token}"})

                        File.open("/tmp/#{@uuid}/layer.tar", 'a') do |file|
                            file.write(compressed_image.body)
                            file.close()
                        end

                        ## 一時的にlayer.tarとして保存したimageを特定ディレクトリに展開する。
                        ## 展開し終わったらlayer.tarは削除する。
                        tarmanager = Tar.new()
                        io = tarmanager.tar("/tmp/#{@uuid}/layer.tar")
                        tarmanager.untar(io, "/tmp/#{@uuid}")
                        FileUtils.rm_rf("/tmp/#{@uuid}/layer.tar")
                    }

                    ## img.sourceという、{image}:{tag}のペアを記録したファイルを作る。(imagesの出力の時に使う)
                    File.open("/tmp/#{@uuid}/img.source", 'a') do |source|
                        source.write("#{@image}:#{@tag}")
                        source.close()
                    end
                    puts "Image id: #{@uuid}"
                rescue => e
                    puts e.message
                    FileUtils.rm_rf("/tmp/#{uuid}")
                end
            end

            def create_image_volume
                ## 論理ボリュームを作成
                uuid="img_#{rand(1..10000)}"
                fs = Oceanus::Utils::FileSystem.new()
                fs.create_volume(uuid)

                ## ファイル差分をボリューム配下にコピー
                begin
                   FileUtils.cp_r(Dir.glob("/tmp/#{@uuid}/*"), "#{fs.saving_path}/#{uuid}", { :force => true })
                rescue ArguementError
                   puts "Image is already created."
                end

                ## 一時的に用意しておいた保存ディレクトリ以下のファイル群を削除
                FileUtils.rm_rf("/tmp/#{@image_id}")
            end

        end
    end
end
