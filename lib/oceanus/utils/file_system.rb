module Oceanus
    module Utils
        class FileSystem
            def initialize
                @saving_path = "/var/oceanus"
            end
            # 論理ボリュームの作成
            def create_volume(uuid)
                cmd = "btrfs subvolume create #{@saving_path}/#{uuid}"
                exec(cmd)
            end

            # スナップショットの作成
            def create_snapshot(image_id)
                cmd = "btrfs subvolume snapshot #{@saving_path}/#{image_id} #{@saving_path}/#{uuid}"
                exec(cmd)
            end

            # 論理ボリュームの削除
            def delete_volume
            end
        end
    end
end
