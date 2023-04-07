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

Ressources:

- [podman.io](https://podman.io/)
- [What is Podman?](https://www.redhat.com/en/topics/containers/what-is-podman)
- [Podman in Action](https://www.manning.com/books/podman-in-action)

# Setup

Install Podman (on Arch Linux):

    # pacman -S podman buildah skopeo fuse-overlayfs slirp4netns

Allow unprivileged users to run containers:

    # sysctl kernel.unprivileged_userns_clone=1

Set `subuid` and `subgid` for user to run containers (e.g. `patrick`):

    # touch /etc/subuid /etc/subgid
    # chmod 644 /etc/subuid /etc/subgid
    # usermod --add-subuids 100000-165535 --add-subgids 100000-165535 patrick

Propagate changes to Podman:

    $ podman system migrate

## Command Line Usage

Test using the alpine container:

    $ podman run -it docker.io/alpine

Build an image:

    $ podman build . -t whatever

Run a container (which exposes port `8080`):

    $ podman run -p 8080:8080 --name whatever whatever

### systemd Integration

Generate a systemd unit:

    $ podman generate systemd --name whatever

Save the output as a unit file:

    $ podman generate systemd --name whatever --new --files
    ./container-whatever.service

Copy the unit file to user's systemd config folder:

    $ mv container-whatever.service ~/.config/systemd/user/

Reload the daemon, and start container using systemd unit:

    $ systemctl --user daemon-reload
    $ systemctl --user enable --now container-whatever.service
    $ systemctl --user restart container-whatever.service

# Networking

Figure out the standard gateway of a network:

    podman network inspect [network] --format '{{ (index .Subnets 0).Gateway }}'
