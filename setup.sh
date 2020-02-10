#!/bin/sh
istioctl manifest apply --set values.kiali.enabled=true,\
values.global.mtls.enabled=true,\
values.global.controlPlaneSecurityEnabled=true,\
values.sidecarInjectorWebhook.rewriteAppHTTPProbe=true
-f ./release/resource.yaml  