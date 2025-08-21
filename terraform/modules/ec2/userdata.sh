#!/bin/bash
set -euxo pipefail
dnf -y update
dnf -y install java-21-amazon-corretto
java -version >> /var/log/java_install.log 2>&1
