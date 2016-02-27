require 'oceanus/utils/image'

module Oceanus
    module Commands
        # イメージの一覧を取得するためのクラス
        class Images
            def self.exec
                puts "REPOSITORY\tTAG\tIMAGE ID"
                image_sources = Oceanus::Utils::Image.get_image_source_mapping
                image_sources.each_with_index do |image_id, source_info|
                    name, tag = source_info.split(":")
                    puts "#{name}\t#{tag}\t#{image_id}"
                end
                puts "image list"
            end
        end
    end
end
