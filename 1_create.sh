#!/bin/bash

GO111MODULE="on" go get sigs.k8s.io/kind@v0.8.1 && kind create cluster --config cluster-config.yaml
