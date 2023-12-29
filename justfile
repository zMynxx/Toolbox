#!/usr/bin/env -S just --justfile
# ^ A shebang isn't required, but allows a justfile to be executed
#   like a script, with `./justfile test`, for example.

set dotenv-filename := '.env'
set dotenv-load := true
# set dotenv-path := './'
set ignore-comments := false
log := "warn"

alias b := build

# Run the build command
build:
    @echo "Building..."

# Run the test command
test:
    @echo "Test"

# Use env vars
env:
    @echo "$GHUSER"

# Run the clean command
clean:
    @echo "Cleaning..."
