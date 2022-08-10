# syntax=docker/dockerfile:1.4
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

FROM amazon/aws-cli:latest

# AWS AppMesh does not send traffic through the envoy proxy if the process is
# running as user 1337, hence why we setup that demouser in this RUN command.
RUN <<EOF
yum upgrade
yum install -y sudo
rm -fr /var/cache
echo "demouser:x:1337:1337:demouser:/home/demouser:/bin/bash" >> /etc/passwd
echo -e "\ndemouser:*:15455:0:99999:7:::" >> /etc/shadow
echo "demouser ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
mkdir /home/demouser
chown 1337:1337 /home/demouser
EOF

COPY entrypoint.sh /entrypoint.sh

USER 1337
ENTRYPOINT ["/bin/sh", "-c", "/entrypoint.sh"]