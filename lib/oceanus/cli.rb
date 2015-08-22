require 'thor'
require 'oceanus/constants'
require 'oceanus/commands/pull'

module Oceanus
    class CLI < Thor
        include Constants 
        desc *DESCRIPTIONS[:pull]
        def pull(image)
            Oceanus::Commands::Pull.exec(image)
        end
    end
end
