#!/bin/bash
$ISTIO_HOME/bin/istioctl manifest apply --set values.kiali.enabled=true --set values.global.mtls.auto=true --set values.global.mtls.enabled=false --set values.gateways.istio-ingressgateway.type=NodePort --set values.gateways.istio-egressgateway.type=NodePort

cat > ingressgateway.yaml <<EOF
apiVersion: v1
kind: Service
metadata:
  annotations: null
  labels:
    app: istio-ingressgateway
    istio: ingressgateway
    release: istio
  name: istio-ingressgateway
  namespace: istio-system
spec:
  ports:
  - name: status-port
    port: 15020
    targetPort: 15020
  - name: http2
    port: 80
    targetPort: 80
    nodePort: 30080
  - name: https
    port: 443
    nodePort: 30443
  - name: kiali
    port: 15029
    targetPort: 15029
  - name: prometheus
    port: 15030
    targetPort: 15030
  - name: grafana
    port: 15031
    targetPort: 15031
  - name: tracing
    port: 15032
    targetPort: 15032
  - name: tls
    port: 15443
    targetPort: 15443
  - name: tcp
    port: 31400
  selector:
    app: istio-ingressgateway
    istio: ingressgateway
  type: NodePort
EOF
kubectl apply -f ingressgateway.yaml
