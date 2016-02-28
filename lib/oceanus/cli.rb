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

        desc *DESCRIPTIONS[:commit]
        def commit(src_container, snapshot_name)
            Oceanus::Commands::Commit.exec(src_container, snapshot_name)
        end

        desc *DESCRIPTIONS[:exec]
        def exec(container, *args)
            Oceanus::Commands::Exec.exec(container, *args)
        end

        desc *DESCRIPTIONS[:images]
        def images
            Oceanus::Commands::Images.exec
        end

        desc *DESCRIPTIONS[:logs]
        def logs(container)
            Oceanus::Commands::Logs.exec(container)
        end

        desc *DESCRIPTIONS[:ps]
        def ps
            Oceanus::Commands::ProcessStatus.exec
        end

        desc *DESCRIPTIONS[:run]
        def run(image, *args)
            Oceanus::Commands::Run.exec(image, *args)
        end

        desc *DESCRIPTIONS[:stop]
        def stop(image)
            Oceanus::Commands::Stop.exec(image)
        end
    end
end
