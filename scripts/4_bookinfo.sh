#!/bin/bash
# https://discuss.istio.io/t/setting-request-headers-with-values-from-a-jwt/5903/4
# |
#       {
#         "auth_jwt"":"%DYNAMIC_METADATA(envoy.filters.http.jwt_authn)%", 
#         "log_type": "access_log",
#         "start_time": "%START_TIME%",
#         "route_name": "%ROUTE_NAME%",
#         "method": "%REQ(:METHOD)%",
#         "path": "%REQ(X-ENVOY-ORIGINAL-PATH?:PATH)%",
#         "protocol": "%PROTOCOL%",
#         "response_code": "%RESPONSE_CODE%",
#         "response_flags": "%RESPONSE_FLAGS%",
#         "bytes_received": "%BYTES_RECEIVED%",
#         "bytes_sent": "%BYTES_SENT%",
#         "duration": "%DURATION%",
#         "upstream_service_time": "%RESP(X-ENVOY-UPSTREAM-SERVICE-TIME)%",
#         "x_forwarded_for": "%REQ(X-FORWARDED-FOR)%",
#         "user_agent": "%REQ(USER-AGENT)%",
#         "request_id": "%REQ(X-REQUEST-ID)%",
#         "authority": "%REQ(:AUTHORITY)%",
#         "upstream_host": "%UPSTREAM_HOST%",
#         "upstream_cluster": "%UPSTREAM_CLUSTER%",
#         "upstream_local_address": "%UPSTREAM_LOCAL_ADDRESS%",
#         "downstream_local_address": "%DOWNSTREAM_LOCAL_ADDRESS%",
#         "downstream_remote_address": "%DOWNSTREAM_REMOTE_ADDRESS%",
#         "requested_server_name": "%REQUESTED_SERVER_NAME%",
#         "istio_policy_status": "%DYNAMIC_METADATA(istio.mixer:status)%",
#         "upstream_transport_failure_reason": "%UPSTREAM_TRANSPORT_FAILURE_REASON%"
#       }

kubectl create ns bookinfo || true
kubectl label namespace bookinfo istio-injection=enabled
kubectl apply -f $ISTIO_HOME/samples/bookinfo/platform/kube/bookinfo.yaml -n bookinfo
kubectl apply -f $ISTIO_HOME/samples/bookinfo/networking/bookinfo-gateway.yaml -n bookinfo
kubectl delete deploy reviews-v2 reviews-v3 -n bookinfo

