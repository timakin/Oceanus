require 'oceanus/utils/file_system'

module Oceanus
    module Commands
        # 特定コンテナ内のログを表示するためのクラス
        class Logs
            def self.exec(container)
                fs = Oceanus::Utils::FileSystem.new()
                File.open("#{fs.saving_path}/logs/#{container}", 'r') do |log|
                    while logline = log.gets
                       puts logline
                    end
                end
            end
        end
    end
end
