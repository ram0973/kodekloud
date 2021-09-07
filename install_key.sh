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

tee -a ~/.ssh/config < END
Host stapp01
  Hostname 172.16.238.10
  User tony
Host stapp02
  Hostname 172.16.238.11
  User steve
Host stapp03
  Hostname 172.16.238.12
  User banner
Host stlb01
  Hostname 172.16.238.14
  User loki
Host stdb01
  Hostname 172.16.239.10
  User peter
Host ststor01
  Hostname 172.16.238.15
  User natasha
Host stbkp01
  Hostname 172.16.238.16
  User clint
Host stmail01
  Hostname 172.16.238.17
  User groot
Host jenkins
  Hostname 172.16.238.19
  User jenkins
END

chmod -R o-rwx,g-rwx ~/.ssh/*

ssh-copy-id -i ~/.ssh/id_rsa.pub tony@stapp01
ssh-copy-id -i ~/.ssh/id_rsa.pub steve@stapp02
ssh-copy-id -i ~/.ssh/id_rsa.pub banner@stapp03
#ssh-copy-id -i ~/.ssh/id_rsa.pub loki@stlb01
#ssh-copy-id -i ~/.ssh/id_rsa.pub peter@stdb01
#ssh-copy-id -i ~/.ssh/id_rsa.pub natasha@ststor01
#ssh-copy-id -i ~/.ssh/id_rsa.pub clint@stbkp01
#ssh-copy-id -i ~/.ssh/id_rsa.pub groot@stmail01
#ssh-copy-id -i ~/.ssh/id_rsa.pub jenkins@jenkins
