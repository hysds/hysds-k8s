#!/bin/bash
BASE_PATH=$(dirname "${BASH_SOURCE}")
BASE_PATH=$(cd "${BASE_PATH}"; pwd)
source ${BASE_PATH}/utils.sh


# create global secrets
create_global_secrets

# create global configmap
create_global_config

# create metrics configmap
create_comp_config metrics

# deploy metrics services
kubectl create -f ${BASE_PATH}/metrics/metrics-redis.yaml \
               -f ${BASE_PATH}/metrics/metrics-elasticsearch.yaml \
               -f ${BASE_PATH}/metrics/metrics.yaml
