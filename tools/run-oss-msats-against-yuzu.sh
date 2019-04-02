#!/bin/bash

set -exu

CERT_DIR=$(mktemp -d)
trap cleanup EXIT
trap cleanup SIGINT
CHILD_PIDS=""

function cleanup {
    rm -rf ${CERT_DIR}

    kill ${CHILD_PIDS}
}

function spawn_bg {
    nohup "$@" > /dev/null 2>&1 &
    CHILD_PIDS="${CHILD_PIDS} $!"
    echo "DE PIDZ $CHILD_PIDS"
}

function forward_port {
    local dest=$1
    local port=$2

    local local_port=1${port}
    spawn_bg bosh -d cf ssh metric-store/0 --opts="-L localhost:${local_port}:${dest}:${port}" --opts="-N"
}

function forward_port_to_metric_store {
    local port=$1

    if [[ -z ${METRIC_STORE_IP:-} ]]; then
        METRIC_STORE_IP=$(bosh -d cf vms | awk '/metric-store/ {print $4}' | head -n 1)
    fi

    forward_port ${METRIC_STORE_IP} ${port}
}

function msats {
  pushd ~/workspace/denver-locks
    set +x
    source ~/workspace/denver-bash-it/custom/environment-targeting.bash
    set -x

    bosh-target yuzu

    # Check that we're connected to bosh
    bosh environment > /dev/null

    # Get certs and keys
    credhub get -n /bosh-yuzu/cf/metric_store > /tmp/metric-store-certs.yml
    bosh int /tmp/metric-store-certs.yml --path=/value/ca > ${CERT_DIR}/ca.crt
    export CA_PATH=${CERT_DIR}/ca.crt
    bosh int /tmp/metric-store-certs.yml --path=/value/certificate > ${CERT_DIR}/ms.crt
    export CERT_PATH=${CERT_DIR}/ms.crt
    bosh int /tmp/metric-store-certs.yml --path=/value/private_key > ${CERT_DIR}/ms.key
    export KEY_PATH=${CERT_DIR}/ms.key
    rm /tmp/metric-store-certs.yml

    credhub get -n /bosh-yuzu/cf/msats_client_secret > /tmp/uaa-client-secret.yml
    export UAA_URL=https://uaa.yuzu.cf-denver.com
    export SKIP_CERT_VERIFY=true
    export CLIENT_ID=msats
    export CLIENT_SECRET=$(bosh int /tmp/uaa-client-secret.yml --path=/value | head -n1 | awk '{print $1};')
    rm /tmp/uaa-client-secret.yml

    # Metric Store GRPC
    forward_port_to_metric_store 8080
    export METRIC_STORE_ADDR=localhost:18080

    # Metric Store Gateway
    forward_port_to_metric_store 8081
    export METRIC_STORE_GATEWAY_URL=http://localhost:18083

    # Metric Store CF OAuth Proxy
    forward_port_to_metric_store 8083
    export METRIC_STORE_CF_AUTH_PROXY_URL=https://localhost:18083

    export LOG_EMIT_TIMEOUT=20s
  popd

  sleep 5

  pushd ~/workspace/oss/metric-store-release/src/pkg/acceptance
    go get github.com/onsi/ginkgo/ginkgo
    go get github.com/onsi/gomega
    ginkgo -r -v
  popd

  # Run indefinitely, useful for debugging
  # while :; do echo 'Hit CTRL+C'; sleep 1; done
}

msats
