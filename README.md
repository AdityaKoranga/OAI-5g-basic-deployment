# OAI-5G-BASIC DEPLOYMENT

## Pre-requisites

1. Install any tool for locally creating cluster. For this installation, we are going to use `kind` for creating cluster. Install from [here](https://kind.sigs.k8s.io/docs/user/quick-start/#installation).

2. `kubectl` allows you to run commands against Kubernetes clusters. Install `kubectl` from [here](https://kubernetes.io/docs/tasks/tools/).

3. Install this `helm-spray`.
```bash
helm plugin install https://github.com/ThalesGroup/helm-spray

# check installed plugins
helm plugin list
```

4. Install `Multus` from [here](https://github.com/k8snetworkplumbingwg/multus-cni), or just follow the below steps:
```bash
git clone https://github.com/k8snetworkplumbingwg/multus-cni
cd multus-cni
cat ./deployments/multus-daemonset-thick-plugin.yml | kubectl apply -f -
cd ../
```

## Installation 

### Clone Repository
```bash
git clone https://github.com/AdityaKoranga/OAI-5g-basic.git

#change directory
cd OAI-5g-basic/
```

### Run Script
```bash
chmod 777 oai-5g-basic.sh
./oai-5g-basic.sh
```

### Crosscheck
On the other terminal, check the running pods:
```bash
watch kubectl get pods -A
```
