require 'lxc'
require 'oceanus/utils/file_system'

module Oceanus
    module Commands
        # コンテナを作成するクラス
        class Run
            def self.exec(image_id, *args)
                c = LXC::Container.new(SecureRandom.hex(10))
                c.create("-t", "none", "-B", "dir", "--dir", "#{fs.saving_path}/#{image_id}")
                c.start
                c.attach do
                    LXC.run_command(args)
                end
                puts "Running image...#{image}"
            end
        end
    end
end
