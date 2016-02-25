require 'thor'
require 'oceanus/constants'
require 'oceanus/commands/pull'
require 'oceanus/commands/build'

module Oceanus
    # 各コマンドを引数付きで呼び出すためのCommand Managingクラス
    class CLI < Thor
        include Constants

        desc *DESCRIPTIONS[:pull]
        def pull(image_and_tag)
            Oceanus::Commands::Pull.exec(image_and_tag)
        end

        desc *DESCRIPTIONS[:build]
        def build(image, path)
            Oceanus::Commands::Build.exec(image, path)
        end
   end
end
