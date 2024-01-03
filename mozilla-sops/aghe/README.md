# Age (pronounded) Aghe

Age is a simple, modern and secure file encryption tool, format, and Go library. It features small explicit keys, no config options, and UNIX-style composability.

[Official github reposiory](https://github.com/FiloSottile/age)

## Installation

```bash
brew install age
```

## Usage examples

```bash
## Generate a key (Public key will be printed)
$ age-keygen --output key.txt
Public key: age1ql3z7hjy54pw3hyww5ayyfg7zqgvc7w3j2elw8zmrj2kg5sfn9aqmcac8p

## Example - Convert a directory into a tarball, while encrypting using age
$ tar cvz ~/data | age --recipient age1ql3z7hjy54pw3hyww5ayyfg7zqgvc7w3j2elw8zmrj2kg5sfn9aqmcac8p > data.tar.gz.age

## Example - Encrypt a tarball using age
$ age --decrypt --identity key.txt data.tar.gz.age > data.tar.gz
```

## Recommended usage

```bash
## Create a hidden directory to store the key
mkdir -p $HOME/.age

## Generate a key and store it in the hidden directory
age-keygen --output $HOME/.age/key.txt
Public key: age1zs3q2vfmr4vy4zw2h5tysnrs73rvmaf6xxx9wut6v0ft0sya9d8qsw2d6f


## Export the key file path as an environment variable
export AGE_KEY_FILE=$HOME/.age/key.txt

## Better - Export the key file path as an environment variable, on shell startup
echo -e 'export SOPS_AGE_KEY_FILE=$HOME/.age/key.txt' >> $HOME/.zshrc
source $HOME/.zshrc
```
