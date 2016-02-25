require 'oceanus/utils/api'

module Oceanus
    module Commands
        # Docker Hubからimageを取得する
        class Pull
            def self.exec(image_and_tag)
                image, tag = image_and_tag.split(":")
                api = Oceanus::Utils::Image.new(image, tag)
                api.get_image
            end
        end
    end
end
