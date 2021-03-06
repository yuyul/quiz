#!/bin/bash
set -e
. common.sh

deploy=$chart-$(getEnvironment)
environmentDomain=$(getDomain)

helm upgrade --install \
    $deploy \
    $chart \
    --namespace $deploy \
    --set imageRegistry=${REGISTRY} \
    --set imageTag=${TAG} \
    --set ingressHost=$environmentDomain \
    --set rabbitmq.ingress.hostName='rabbit.'$environmentDomain \
    --debug \
    --wait
    
runTests $deploy
