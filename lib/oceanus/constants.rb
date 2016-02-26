module Oceanus
    module Constants
        DESCRIPTIONS = {
            pull: ["pull {image_name} (e.g. oceanus pull centos)", "Pull image to build a container"],
            build: ["build author/image ./Dockerfile_dir", "build an existing image with Dockerfile"],
            rm: ["rm {container_id}", "Remove a container"],
            rmi: ["rmi {image_id}", "Remove an image"]
        }
    end
end
