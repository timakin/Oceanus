module Oceanus
    module Utils
        class FileSystem
            attr_reader :saving_path

            def initialize
                @saving_path = "/var/oceanus"
            end

            # 論理ボリュームの作成
            def create_volume(uuid)
                cmd = "btrfs subvolume create #{@saving_path}/#{uuid}"
                exec(cmd)
            end

            # スナップショットの作成
            def create_snapshot(image_id, uuid)
                cmd = "btrfs subvolume snapshot #{@saving_path}/#{image_id} #{@saving_path}/#{uuid}"
                exec(cmd)
            end

            # 論理ボリュームの削除
            def delete_volume(image_id)
                cmd = "btrfs subvolume delete #{@saving_path}/#{image_id}"
                exec(cmd)
            end
        end
    end
end
