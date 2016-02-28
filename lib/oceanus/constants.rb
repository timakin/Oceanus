module Oceanus
    module Constants
        DESCRIPTIONS = {
            pull: ["pull {image_name} (e.g. oceanus pull centos)", "Pull image to build a container"],
            build: ["build author/image ./Dockerfile_dir", "build an existing image with Dockerfile"],
            rm: ["rm {container_id}", "Remove a container"],
            rmi: ["rmi {image_id}", "Remove an image"],
            commit: ["commit {container_name} ", "Create a new image from a container's changes"],
			exec: ["exec", "Run a command in a running container"],
			images: ["images", "List images"],
			logs: ["logs", "Fetch the logs of a container"],
			ps: ["ps", "List containers"],
			run: ["run", "Run a command in a new container"],
			stop: ["stop", "Stop a running container"]
        }
    end
end
