# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0
#!/bin/bash

set -e

for i in {1..20} # Max 20 Files
do
    # Retrieve Bucket Name
    BUCKET_NAME="S3_BUCKET_FILE_"$i
    if [[ -z "${!BUCKET_NAME}" ]]; then
       echo "$BUCKET_NAME environment variable is not set"
       exit 0
    fi
    echo "$BUCKET_NAME has been set as ${!BUCKET_NAME}"

    # Retrieve File Location in Bucket
    SRC_FILE_PATH="SRC_FILE_PATH_FILE_"$i
    if [ -z ${!SRC_FILE_PATH} ]; then
       echo "$SRC_FILE_PATH environment variable is not set"
       exit 0
    fi
    echo "$SRC_FILE_PATH has been set as ${!SRC_FILE_PATH}"

    # Retrieve Target File Location in Container
    DEST_FILE_PATH="DEST_FILE_PATH_FILE_"$i
    if [ -z ${!DEST_FILE_PATH} ]; then
       echo "$DEST_FILE_PATH environment variable is not set"
       exit 0
    fi
    echo "$DEST_FILE_PATH has been set as ${!DEST_FILE_PATH}"

    # Remove any directories from the path
    FILE_NAME=$(echo ${!SRC_FILE_PATH} | xargs basename)
    echo $FILE_NAME

    # Download the file from s3 to the local directory
    aws s3 cp \
      s3://${!BUCKET_NAME}/${!SRC_FILE_PATH} \
      /home/demouser/$FILE_NAME

    # Copy the file to a mounted directory. The assumption is the mounted
    # directory is a bind mount, therefore sudo privileges are required.
    sudo cp /home/demouser/$FILE_NAME ${!DEST_FILE_PATH}
done