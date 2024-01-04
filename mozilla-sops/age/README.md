# Age (pronounded) Aghe

Age is a simple, modern and secure file encryption tool, format, and Go library. It features small explicit keys, no config options, and UNIX-style composability.

[Official github reposiory](https://github.com/FiloSottile/age)

---

# Table of Contents

1. [Installation](#installation)
2. [Usage examples](#usage-examples)
3. [Getting Started](#getting-started)
4. [Configurations](#configurations)
5. [Further examples](#further-examples)
6. [VSCode extension](#vscode-extension)
7. [IMPORTANT - Do not commit the secrets to git](#important---do-not-commit-the-secrets-to-git)

---

# Installation

```bash
brew install age
```

# Usage examples

```bash
## Generate a key (Public key will be printed)
$ age-keygen --output key.txt
Public key: age1ql3z7hjy54pw3hyww5ayyfg7zqgvc7w3j2elw8zmrj2kg5sfn9aqmcac8p

## Example - Convert a directory into a tarball, while encrypting using age
$ tar cvz ~/data | age --recipient age1ql3z7hjy54pw3hyww5ayyfg7zqgvc7w3j2elw8zmrj2kg5sfn9aqmcac8p > data.tar.gz.age

## Example - Encrypt a tarball using age
$ age --decrypt --identity key.txt data.tar.gz.age > data.tar.gz
```

# Getting Started

```bash
## Create a hidden directory to store the key
mkdir -p $HOME/.age

## Generate a key and store it in the hidden directory
age-keygen --output $HOME/.age/key.txt
Public key: age1zs3q2vfmr4vy4zw2h5tysnrs73rvmaf6xxx9wut6v0ft0sya9d8qsw2d6f
```

---

# Configurations

## Set the key file you want

### Method 1 - Export the key file path

Export the key file path as an environment variable.

```bash
export AGE_KEY_FILE=$HOME/.age/key.txt
```

### Method 2 - Shell Configuration

Export the key file path as an environment variable, on shell startup.

```bash
echo -e 'export SOPS_AGE_KEY_FILE="$HOME/.age/key.txt"' >> $HOME/.zshrc
source $HOME/.zshrc
```

## Method 3 - Create a .sops.yaml file (Only for the CLI)

.sops.yaml file is a configuration file for sops. It can be used to specify the age key file path, and other configuration options.
This file will be looked up in the current directory, and all parent directories.

```yaml
# creation rules are evaluated sequentially, the first match wins
creation_rules:
  # upon creation of a file that matches the pattern *.yaml,
  # and age is used
  - path_regex: .yaml$

  ## This key is the public key of the age key pair
  - age: "age1zs3q2vfmr4vy4zw2h5tysnrs73rvmaf6xxx9wut6v0ft0sya9d8qsw2d6f"
```

## Method 4 - Create a .sopsrc file (Only for the VSCode extension)

.sopsrc file is a configuration file for sops. It can be used to specify the age key file path, and other configuration options.

```yaml
awsProfile: my-profile-1
gcpCredentialsPath: /home/user/Downloads/my-key.json
ageKeyFile: /home/user/age.txt
```

---

## Further examples

```bash
## Create a k8s secret
kubectl create secret generic sops-aghe-secret-example --from-literal=SECRET1=password --from-literal=SECRET2=securepassword --dry-run=client -o yaml > secrets.yaml

## Encrypt using sops and age (MacOS)
#--age-recipient-file $HOME/.age/key.txt
sops --encrypt --age $(cat $SOPS_AGE_KEY_FILE | grep -o "public key: .*" | awk '{print $NF}') --encrypted-regex '^(data|stringData)$' --in-place ./secrets.yaml

## Decrypt using sops and age (MacOS)
sops --decrypt --age $(cat $SOPS_AGE_KEY_FILE | grep -o "public key: .*" | awk '{print $NF}') --encrypted-regex '^(data|stringData)$' --in-place ./secrets.yaml
```

## [VSCode extension](https://marketplace.visualstudio.com/items?itemName=signageos.signageos-vscode-sops)

```yaml
Name: @signageos/vscode-sops
Id: signageos.signageos-vscode-sops
Description:
Version: 0.8.0
Publisher: signageOS.io
VS Marketplace Link: https://marketplace.visualstudio.com/items?itemName=signageos.signageos-vscode-sops
```

# IMPORTANT - Do not commit the secrets to git

Make sure to have in your `.gitignore` file the following line:

```bash
*.decrypted~*
```

This will prevent any of the decrypted secrets from being committed to git using regex.
