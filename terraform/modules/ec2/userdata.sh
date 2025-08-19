
#!/bin/bash

set -euxo pipefail
def -y update
def -y install java-21-amazon-corretto
java -version >> /var/log/java_install.log 2>&1
