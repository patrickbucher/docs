# Getting Started

Install Ansible (on Arch Linux):

    # pacman -S ansible

Create an `inventory` (or `hosts.ini`) file in a working directory listing the
hostnames or IPs:

    [local_vms]
    alma
    debian
    openbsd
    ubuntu

Make sure that Python is installed on all the clients.

Run your first command to check if all hosts of the inventory are reachable
(replace `[username]` with the actual username of a user that has an installed
SSH key):

    $ ansible -i inventory local_vms -m ping -u [username]
    debian | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
    }:
    ...

The `-m` option provides a module name.

Check free disk space on the inventory's hosts:

    $ ansible -i inventory local_vms -a 'df -h' -u patrick
    
The `-a` option provides arguments, here for the shell.

Run a playbook:

    $ ansible-playbook -i inventory -l linux -u patrick playbook.yml

Where `l` restricts the hosts in the inventory to the `[linux]` group.

# Documentation

- [Ansible Documentation](https://docs.ansible.com/ansible/latest/)
- [Ansible Galaxy](https://galaxy.ansible.com/)
- [Glossary](https://docs.ansible.com/ansible/latest/reference_appendices/glossary.html)
