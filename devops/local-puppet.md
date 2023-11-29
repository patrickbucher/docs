# Local Puppet

bring up initial vm

    vagrant init hashicorp/bionic64
    vagrant up

ssh into it

    ssh -p 2222 vagrant@vagrant
    # password: vagrant

shared folder (folder in which vagrant init was run), containing Vagrantfile

    /vagrant

get rid of the vm

    vagrant destroy

remove the vm image

    vagrant box remove

restart vm with new vonfiguration

    vagrant reload

bring up vm with provisioning

    varant up --provision
