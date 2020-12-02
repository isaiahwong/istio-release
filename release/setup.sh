#!/bin/sh
# https://istio.io/docs/reference/config/installation-options/
istioctl manifest apply --set values.global.mtls.enabled=true \
--set values.global.controlPlaneSecurityEnabled=true \
--set values.sidecarInjectorWebhook.rewriteAppHTTPProbe=true \
--set values.global.k8sIngress.enabled=true \
--set values.pilot.resources.requests.memory=1024Mi \
--set values.global.k8sIngress.enableHttps=true \
--set values.global.proxy.accessLogFile="/dev/stdout"
# --set values.gateways.istio-ingressgateway.sds.enabled=true \

