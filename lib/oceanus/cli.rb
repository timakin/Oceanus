require 'thor'
require 'oceanus/commands/pull'

module Oceanus
    class CLI < Thor
        desc "oceanus pull {image_name} (e.g. oceanus pull centos)", "Pull image to build a container"
        def pull(image)
            Oceanus::Commands::Pull.exec(image)
        end
    end
end
