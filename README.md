# OAI-5g-basic
one line script file for deploying oai-5g-basic

## Before starting:
**Make sure You have you have installed KIND or any other tool for making cluster. In this I have used KIND for making the cluster.** 
* If you want to use any other tool for making cluster then change the line *kind create cluster* in the script file.

## Start Deploying:
git clone:
```
git clone https://github.com/AdityaKoranga/OAI-5g-basic.git
```
Then:
```
cd OAI-5g-basic/
```
Final step :
```
./oai-5g-basic.sh
```
## Things done in this script:
* Created kind cluster
* Used multus cni
* installed helm spray
* Cloned https://gitlab.eurecom.fr/oai/cn5g/oai-cn5g-fed.git
* Ran script file sync components
* Changed host interface to "eth0" in the values.yaml file
* Updated entries in the database oai_db-basic.sql
* Helm dependency update
* Finally deployed using helm spray.

