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

        desc *DESCRIPTIONS[:rm]
        def rm(container_id)
            Oceanus::Commands::Remove.container(container_id)
        end

        desc *DESCRIPTIONS[:rmi]
        def rmi(image_id)
            Oceanus::Commands::Remove.image(image_id)
        end
   end
end
