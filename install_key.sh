#!/usr/bin/env bash
# Make keypair and copy it to servers

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
# set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail
# Turn on traces, useful while debugging but commented out by default
# set -o xtrace

ssh-keygen
chmod -R o-rwx,g-rwx ~/.ssh/*

tee -a ~/.ssh/config << END
Host stapp01
  Hostname 172.16.238.10
  User tony

Host stapp02
  Hostname 172.16.238.11
  User steve

Host stapp03
  Hostname 172.16.238.12
  User banner

Host stdb01
  Hostname 172.16.239.10
  User peter
END

chmod -R o-rwx,g-rwx ~/.ssh/*
ssh-copy-id -i ~/.ssh/id_rsa.pub tony@stapp01
ssh-copy-id -i ~/.ssh/id_rsa.pub steve@stapp02
ssh-copy-id -i ~/.ssh/id_rsa.pub banner@stapp03
#ssh-copy-id -i ~/.ssh/id_rsa.pub peter@stdb01


