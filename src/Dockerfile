# syntax=docker/dockerfile:1
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

FROM public.ecr.aws/aws-cli/aws-cli:latest

# Run as non-root UID 1337, which Envoy-based service meshes (such as AWS App
# Mesh) exclude from proxying. sudo lets the script write to bind mounts.
RUN <<EOF
yum upgrade -y
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