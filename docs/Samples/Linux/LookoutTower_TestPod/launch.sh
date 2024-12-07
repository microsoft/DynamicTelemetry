#!/bin/bash

helm install lookout-tower-appy . --namespace default --set serviceAccount.create=false --set serviceAccount.name=workload-identity-sa