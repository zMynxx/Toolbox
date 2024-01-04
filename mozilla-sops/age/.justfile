#!/usr/bin/env -S just --justfile
# ^ A shebang isn't required, but allows a justfile to be executed
#   like a script, with `./justfile test`, for example.

set ignore-comments := false
log := "warn"


#############
## Chooser ##
#############
default:
  @just --choose

#############
## Install ##
#############
# Install Sops and Age
install:
    @echo "Installing Sops with Age..."
    brew install sops age

###############
## Configure ##
###############
# Run the build command
config:
    @echo "Configuring Sops with Age..."
    mkdir -p ~/.sops/age
    age-keygen -o ~/.sops/age/key.txt
    echo 'export SOPS_AGE_KEY_FILE="$HOME/.sops/age/key.txt" >> ~/.zshrc'
    source ~/.zshrc
    echo 'ageKeyFile: ~/.sops/age/key.txt' >> .sopsrc
    code --install-extension signageos.signageos-vscode-sops --install-extension mikestead.dotenv
    cat <<-YAML > .sops.yaml
    creation_rules:
    - path_regex: .yaml$
    - age: $(cat $SOPS_AGE_KEY_FILE | grep -o "public key: .*" | awk '{print $NF}')
    YAML

################
## Encryption ##
################
# Encrypt a file
encrypt *FILE:
    @echo "Encrypting $FILE..."
    sops --encrypt --in-place $FILE

################
## Decryption ##
################
# Encrypt a file
decrypt *FILE:
    @echo "Decrypting $FILE..."
    sops --decrypt --in-place $FILE