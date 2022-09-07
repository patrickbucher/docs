# Notes

- Podman containers can run without root privileges.
- Containers can be built with Buildah and Skopeo.
- Pod: One ore more containers sharing a namespace and cgroups.
- Podman can be used as an alias for Docker (`alias docker=podman`), but has
  more capabilities.
- Podman runs containers on single Linux nodes together with systemd.
- Containers can be started/managed over a REST API.
- Podman runs OCI (Open Container Initiative) containers.
- Podman containers can run systemd.
- A podman container is a child process of the podman command.
- Podman completely separates user namespaces.
- Podman does not need a daemon to run. (The docker daemon is a single point of
  failure.)
- Podman supports Pods (like Kubernetes) and runs Kubernetes YAML.
- The `docker` group virtually has root rights; not so with Podman.

# Setup

Install Podman (on Arch Linux):

    # pacman -S podman

