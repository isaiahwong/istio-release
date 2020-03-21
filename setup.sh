#!/bin/sh
istioctl manifest apply --set values.kiali.enabled=true,\
values.global.mtls.enabled=true,\
values.grafana.enabled=true,\
values.global.controlPlaneSecurityEnabled=true,\
values.sidecarInjectorWebhook.rewriteAppHTTPProbe=true,\
values.global.proxy.accessLogFile="/dev/stdout"