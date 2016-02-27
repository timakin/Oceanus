require 'lxc'
require 'oceanus/utils/file_system'

module Oceanus
    module Commands
        # コンテナからimageを作成する
        class Commit
            def self.exec(src, snapshot_name)
                # lxcの機能を使ってsnapshotを作成
                c = LXC::Container.new(src)
                # 事前に停止
                c.stop
                c.clone("-s", "-o", src, "-n", snapshot_name)

                # そのsnapshotをoceanus snapshot保存用のディレクトリに移動する
                fs = Oceanus::Utils::FileSystem.new()
                FileUtils.cp_r("/var/lib/lxc/#{snapshot_name}", fs.saving_path + snapshot_name)
            end
        end
    end
end
