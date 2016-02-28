module Oceanus
    module Utils
        class Parser
            PROCEDURE_IDENTIFIERS = ["FROM", "MAINTAINER", "RUN", "ADD", "CMD", "ENTRYPOINT", "WORKDIR", "ENV", "USER", "EXPOSE", "VOLUME"]

            class << self
                def get_input_commands(path)
                    return if File.exists?(build_file_path(path))

                    cmd_map = Hash.new
                    PROCEDURE_IDENTIFIERS.each do |id|
                        cmd_map.unshift(id, [])
                    end

                    File.open(build_file) do |line|
                        id_and_procedure = line.split(" ")
                        procedure_id = id_and_procedure[0]
                        if PROCEDURE_IDENTIFIERS.exists?(procedure_id) && id_and_procedure.length > 1
                            cmd_map[procedure_id] << id_and_procedure[1..-1]
                        end
                    end

                    cmd_map
                end
            end

            private

            def build_file_path(path)
                path + "/Dockerfile"
            end
        end
    end
end
