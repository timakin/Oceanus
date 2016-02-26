require 'oceanus/utils/file_system'
require 'lxc'

module Oceanus
    module Commands
        # コンテナ、imageを削除するクラス
        class Remove
            def self.image(image_id)
                fs = Oceanus::Utils::FileSystem.new()
                fs.delete_volume(image_id)
                puts "Removing image: #{image_id}"
            end

            def self.container(container_id)
                c = LXC::Container.new(container_id)
                c.destroy
                puts "Removing container: #{container_id}"
            end
        end
    end
end
