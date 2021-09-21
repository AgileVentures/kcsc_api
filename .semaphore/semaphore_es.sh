#!/bin/bash
# Install a custom ElasticSearch version - https://www.elastic.co/products/elasticsearch
#
# To run this script on SemaphoreCI, add the following command to your project's build setup:
# \curl -sSL <RAW_URL_FOR_THIS_SCRIPT> | bash -s
#
ELASTICSEARCH_VERSION="0.90.13"
ELASTICSEARCH_PORT="9200"
ELASTICSEARCH_DIR="$SEMAPHORE_PROJECT_DIR/elasticsearch"
ELASTICSEARCH_WAIT_TIME="15"

echo "ELASTICSEARCH_VERSION = $ELASTICSEARCH_VERSION"
echo "ELASTICSEARCH_PORT = $ELASTICSEARCH_PORT"
echo "ELASTICSEARCH_DIR = $ELASTICSEARCH_DIR"
echo "ELASTICSEARCH_WAIT_TIME = $ELASTICSEARCH_WAIT_TIME"

echo "Stop existing ElasticSearch server (1.3.9)..."
sudo service elasticsearch stop

# The download location of version 2.x seems to follow a different URL structure to 1.x
if [ ${ELASTICSEARCH_VERSION:0:1} -eq 2 ]
then
  ELASTICSEARCH_DL_URL="https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/${ELASTICSEARCH_VERSION}/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz"
else
  ELASTICSEARCH_DL_URL="https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz"
fi
set -e

CACHED_DOWNLOAD="${SEMAPHORE_CACHE_DIR}/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz"

echo "Creating ElasticSearch folder..."
mkdir -p "${ELASTICSEARCH_DIR}"

echo "Downloading ElasticSearch $ELASTICSEARCH_VERSION..."
wget --continue --output-document "${CACHED_DOWNLOAD}" "${ELASTICSEARCH_DL_URL}"

echo "Unpacking downloaded ElasticSearch..."
tar -xaf "${CACHED_DOWNLOAD}" --strip-components=1 --directory "${ELASTICSEARCH_DIR}"

# Configure elasticsearch
echo "Configuring downloaded ElasticSearch..."
echo "http.port: ${ELASTICSEARCH_PORT}" >> ${ELASTICSEARCH_DIR}/config/elasticsearch.yml
echo "index.number_of_shards: 1"        >> ${ELASTICSEARCH_DIR}/config/elasticsearch.yml
echo "index.number_of_replicas: 0"      >> ${ELASTICSEARCH_DIR}/config/elasticsearch.yml

# Make sure to use the exact parameters you want for ElasticSearch and give it enough sleep time to properly start up
nohup bash -c "${ELASTICSEARCH_DIR}/bin/elasticsearch 2>&1" &

echo "Waiting for ElasticSearch to start..."
sleep "${ELASTICSEARCH_WAIT_TIME}"