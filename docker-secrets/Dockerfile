FROM debian

## Mount a secret from the host
RUN --mount=type=secret,id=secrets,target=/run/secrets/secrets \
    echo "The secret is: $(cat /run/secrets/secrets)"

## Download git and ssh
RUN apt-get update && apt-get install -y \
    git \
    openssh-client

## Download public key for github.com
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

## Mount a ssh key from the host, and use it to clone a private repo

RUN --mount=type=ssh \
    git clone git@github.com:zMynxx/RenderingBatch.git