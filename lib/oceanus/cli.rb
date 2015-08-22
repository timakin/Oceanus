require 'thor'
require 'oceanus/constants'
require 'oceanus/commands/pull'
require 'oceanus/commands/build'

module Oceanus
    class CLI < Thor
        include Constants

        desc *DESCRIPTIONS[:pull]
        def pull(image)
            Oceanus::Commands::Pull.exec(image)
        end
        
        desc *DESCRIPTIONS[:build]
        def build(image, path)
            Oceanus::Commands::Build.exec(image, path)
        end
   end
end
