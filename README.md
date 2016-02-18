# Personal Vagrant Development Environment

Creates a Vagrant machine running on OSX, with the following auto-installed and configured.

* Amazon AWS Cloud Tools: awscli, ecs-cli
* Rackspace Cloud Tools: rack, nova, supernova, superglance
* Google Cloud Tools: gcloud
* Docker Tools: docker, docker-compose
* Kubernetes Tools: kubectl
* Network Tools: nmap, traceroute, whois

# Preparing your box for Vagrant

## Preparing your box for Vagrant using Brew (the smart way!):

* Install Brew (http://brew.sh/)

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

* Install a few other packages

```
brew install git python wget curl gitslave brew-cask tree nmap ssh-copy-id
```

* Install vagrant and virtualbox

```
brew cask install virtualbox
brew cask install vagrant
```

* Install vbguest plugin

```
vagrant plugin install vagrant-vbguest
```

* Install cachier plugin (caches the APT, download, and Maven resources so that the box builds faster)

```
vagrant plugin install vagrant-cachier
```

# Configure a few things (Recommended)

All of these will make your life easier:

### Configure Git Configuration (Optional)

Set defaults for your git configuration (email, name, aliases, etc)

```
cp ./conf/dot.gitconfig.example ./conf/dot.gitconfig
edit ./conf/dot.gitconfig
```

### Configure AWS CLI Tools (Optional)

The pre-installed AWS cli commands require configuration to work.

Documentation for configuration is found here [http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#cli-config-files](AWS CLI Configuration)

```
cp ./secrets/dot.aws/config.example ./secrets/dot.aws/config
edit ./secrets/dot.aws/config

cp ./secrets/dot.aws/credentials.example ./secrets/dot.aws/credentials
edit ./secrets/dot.aws/credentials
```

### Configurate Rackspace CLI Tools (Optional)

The pre-installed Rackspace cli commands require configuration to work.

```
cp ./secrets/dot.rax/dot.supernova.example ./secrets/dot.rax/dot.supernova
edit ./secrets/dot.rax/dot.supernova
```

### Configure SSH Keys (Optional)

If you'd like to put your ssh directory on the vagrant box, so that you may ssh
from the vagrant machine as you would your host machine, copy the contents of
your .ssh directory to ./secrets/dot.ssh/

```
cp ~/.ssh/* ./secrets/dot.ssh/
```

### Configure Code Directory Mount (Optional)

If you'd like to mount a directory from your host machine directly into the
vagrant machine, you may edit the synced folder directive in the Vagrant file.
The default will mount the host ~/Dev directory to the vagrant /vagrant/Dev directory.

```
# edit ./Vagrantfile if you have your directories to mount

    if File.directory?("~/Dev")
      dev.vm.synced_folder "~/Dev", "/vagrant/Dev"
    end
```


# Using this Vagrant image

## Start the virtual machine

```vagrant up```

## Connect to the machine

```vagrant ssh```

## Suspend the machine (so it doesn't eat into your battery life)

```vagrant suspend```

## Import your key to AWS

Publish your keypair to every region in AWS that you will use

```
export KEY_NAME=${USER}
export PRIVATE_KEY="${HOME}/.ssh/id_rsa"
export PUBKEY_MATERIAL=`openssl rsa -in ${PRIVATE_KEY} -pubout 2>/dev/null|tail -n +2| head -n -1| tr -d '\n'`
export PROFILES='dev-us-west-1 dev-us-west-2 dev-us-east-1'
for i in ${PROFILES}; do
  aws ec2 delete-key-pair --profile=$i --key-name ${KEY_NAME};
  aws ec2 import-key-pair --profile=$i --key-name ${KEY_NAME} --public-key-material ${PUBKEY_MATERIAL};
done
```




