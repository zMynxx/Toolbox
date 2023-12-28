#!/usr/bin/env -S just --justfile
# ^ A shebang isn't required, but allows a justfile to be executed
#   like a script, with `./justfile test`, for example.

set dotenv-filename := '.env'
set dotenv-load := false
# set dotenv-path := './'
set ignore-comments := false
set export
log := "warn"


## Playbook Commands
playbookdir := "./playbooks/"
playbookfile := playbookdir + "docker.yaml"

# Run the playbook command
playbook:
    @echo "playbooking..."
    @ansible-playbook $playbookfile
alias p := playbook

## Ansible Vault Commands
vaultfile := "vault.yaml"
vaultpath := "./vars/" + vaultfile

# Run the encrypt command
encrypt:
    @echo "encrypting..."
    @ansible-vault encrypt $vaultpath
alias e := encrypt

# Run the view command
view:
    @echo "viewing..."
    @ansible-vault view $vaultpath
alias v := view

# Run the edit command
edit:
    @echo "editing..."
    @ansible-vault edit $vaultpath

# Run the dencrypt command
dencrypt:
    @echo "dencrypting..."
    @ansible-vault decrypt $vaultpath
alias de := dencrypt

# Run the test command
test:
    @echo "Test"
    @echo $vaultpath

# Install the dependencies
install:
    @echo "Installing dependencies..."
    @ansible-galaxy install -r requirements.yaml
alias i := install

## SSH Commands
# Create the SSH key pair
ssh-key:
    @echo "Creating SSH key pair..."
    @ssh-keygen -t rsa -b 4096 -C "ansible@localhost" -f $HOME/.ssh/ansible

# Add ansible public key to authorized keys
set-public-key:
    @echo "Setting public key..."
    @cat $HOME/.ssh/ansible.pub >> $HOME/.ssh/authorized_keys

# Run the clean command
clean:
    @echo "Cleaning..."
    @rm -rf $HOME/.ssh/ansible*