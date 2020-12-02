#!/bin/sh
istioctl manifest apply \
--set values.kiali.enabled=true \
--set values.grafana.enabled=true \
--set values.global.controlPlaneSecurityEnabled=true \
--set values.sidecarInjectorWebhook.rewriteAppHTTPProbe=true \
--set meshConfig.accessLogFile="/dev/stdout"

