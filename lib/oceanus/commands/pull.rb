require 'oceanus/utils/image'

module Oceanus
    module Commands
        # Docker Hubからimageを取得する
        class Pull
            def self.exec(image_and_tag)
                image, tag = image_and_tag.split(":")
                image_manager = Oceanus::Utils::Image.new(image, tag)
                image_manager.get_image
            end
        end
    end
end
