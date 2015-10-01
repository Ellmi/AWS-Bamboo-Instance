#!/bin/bash

# Load env variables
source bin/config.sh

#prepare artifacts

rm -rf aws-bamboo-files ${BAMBOO_ARTIFACT_NAME} /tmp/master-bamboo-params.json
mkdir -p aws-bamboo-files
cp -r files/* aws-bamboo-files
tar czvf ${BAMBOO_ARTIFACT_NAME} aws-bamboo-files

# Upload artifacts to s3 bucket
echo 'Uploading aws-bamboo-files.tar.gz to AWS s3 bucket...'
aws s3 ${BAMBOO_ARTIFACT_NAME} s3://${BAMBOO_BUCKET_NAME}/${BAMBOO_ARTIFACT_NAME}

# Substitute values in master params file
sed "s/XXX-ArtifactName-XXX/${BAMBOO_ARTIFACT_NAME}/" aws/master/bamboo-params.json \
| sed "s/XXX-BucketName-XXX/${BAMBOO_BUCKET_NAME}/" \
> /tmp/master-bamboo-params.json

# Remove tmp files
rm -rf ${BAMBOO_ARTIFACT_NAME} aws-bamboo-files