#!/bin/bash
BASE_PATH=$(dirname "${BASH_SOURCE}")
BASE_PATH=$(cd "${BASE_PATH}"; pwd)
source ${BASE_PATH}/utils.sh


# echo metrics interfaces
METRICS_FQDN=$(kubectl get pod -l run=metrics -o jsonpath="{.items[0].spec.nodeName}")
METRICS_IP=$(kubectl get pod -l run=metrics -o jsonpath="{.items[0].status.hostIP}")
METRICS_PORT=$(kubectl get service metrics -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')
METRICS_KIBANA_PORT=$(kubectl get service metrics -o jsonpath='{.spec.ports[?(@.name=="kibana")].nodePort}')
METRICS_SSH_PORT=$(kubectl get service metrics -o jsonpath='{.spec.ports[?(@.name=="ssh")].nodePort}')
echo "The metrics interfaces will be accessible by one the urls below depending on how your Kubernetes cluster is setup:"
echo "HTTPS:           https://${METRICS_FQDN}:${METRICS_PORT}/metrics"
echo "                 https://${METRICS_IP}:${METRICS_PORT}/metrics"
echo "                 https://localhost:${METRICS_PORT}/metrics"
echo "Kibana:          https://${METRICS_FQDN}:${METRICS_KIBANA_PORT}"
echo "                 https://${METRICS_IP}:${METRICS_KIBANA_PORT}s"
echo "                 https://localhost:${METRICS_KIBANA_PORT}"
echo ""
echo "To ssh into metrics:"
echo "                 ssh -i ${BASE_PATH}/secrets/id_rsa -p ${METRICS_SSH_PORT} ops@${METRICS_FQDN}"
echo "                 ssh -i ${BASE_PATH}/secrets/id_rsa -p ${METRICS_SSH_PORT} ops@${METRICS_IP}"
echo "                 ssh -i ${BASE_PATH}/secrets/id_rsa -p ${METRICS_SSH_PORT} ops@localhost"
