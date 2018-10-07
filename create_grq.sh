#!/bin/bash
BASE_PATH=$(dirname "${BASH_SOURCE}")
BASE_PATH=$(cd "${BASE_PATH}"; pwd)

# create configmaps
kubectl create configmap hysds-global-config --from-file=${BASE_PATH}/config
kubectl create configmap hysds-grq-config --from-file=${BASE_PATH}/grq/config

# start services
kubectl create -f ${BASE_PATH}/grq/grq-redis.yaml \
               -f ${BASE_PATH}/grq/grq-elasticsearch.yaml \
               -f ${BASE_PATH}/grq/grq.yaml
sleep 5

# echo grq interfaces
${BASE_PATH}/get_grq_urls.sh
