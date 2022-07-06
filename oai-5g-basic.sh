#!/bin/bash

install_helmspray()
{
	helm plugin install https://github.com/ThalesGroup/helm-spray
	helm plugin list
}

set -xe


#start by making a cluster
kind create cluster

#let's provide multus-cni
git clone https://github.com/k8snetworkplumbingwg/multus-cni
cd multus-cni
cat ./deployments/multus-daemonset-thick-plugin.yml | kubectl apply -f -
cd ../


#install helm spray
install_helmspray || true


#oai-5g
git clone  https://gitlab.eurecom.fr/oai/cn5g/oai-cn5g-fed.git
cd oai-cn5g-fed/

#resync to the last 'master' commit
git fetch --prune
git checkout master
git rebase origin/master

#let's run the script
./scripts/syncComponents.sh --nrf-branch develop --amf-branch develop \
                              --smf-branch develop --spgwu-tiny-branch develop \
                              --ausf-branch develop --udm-branch develop \
                              --udr-branch develop --upf-vpp-branch develop \
                              --nssf-branch ts
cd ./charts/oai-5g-core/oai-5g-basic/
sed -i 's/hostInterface: "ens2f0np0"/hostInterface: "eth0" / ' values.yaml

cd ../mysql/initialization/


sed -i ' 152i INSERT INTO `AuthenticationSubscription` (`ueid`, `authenticationMethod`, `encPermanentKey`, `protectionParameterId`, `sequenceNumber`, `authenticationManagementField`, `algorithmId`, `encOpcKey`, `encTopcKey`, `vectorGenerationInHss`, `n5gcAuthMethod`, `rgAuthenticationInd`, `supi`) VALUES ' oai_db-basic.sql


sed -i " 153i ('208990100001124', '5G_AKA', 'fec86ba6eb707ed08905757b1bb44b8f', 'fec86ba6eb707ed08905757b1bb44b8f', '{\"sqn\": \"000000000020\", \"sqnScheme\": \"NON_TIME_BASED\", \"lastIndexes\": {\"ausf\": 0}}', '8000', 'milenage', 'c42449363bbad02b66d16bc975d77cc1', NULL, NULL, NULL, NULL, '208990100001124'); " oai_db-basic.sql


sed -i ' 154i INSERT INTO `SessionManagementSubscriptionData` (`ueid`, `servingPlmnid`, `singleNssai`, `dnnConfigurations`) VALUES ' oai_db-basic.sql


sed -i " 155i ('208990100001124', '20899', '{\"sst\": 1, \"sd\": \"10203\"}','{\"oai\":{\"pduSessionTypes\":{ \"defaultSessionType\": \"IPV4\"},\"sscModes\": {\"defaultSscMode\": \"SSC_MODE_1\"},\"5gQosProfile\": {\"5qi\": 6,\"arp\":{\"priorityLevel\": 1,\"preemptCap\": \"NOT_PREEMPT\",\"preemptVuln\":\"NOT_PREEMPTABLE\"},\"priorityLevel\":1},\"sessionAmbr\":{\"uplink\":\"100Mbps\", \"downlink\":\"100Mbps\"},\"staticIpAddress\":[{\"ipv4Addr\": \"12.1.1.85\"}]}}'); " oai_db-basic.sql


sed -i ' 156i INSERT INTO `SessionManagementSubscriptionData` (`ueid`, `servingPlmnid`, `singleNssai`, `dnnConfigurations`) VALUES ' oai_db-basic.sql


sed -i " 157i ('208990100001125', '20899', '{\"sst\": 1, \"sd\": \"10203\"}','{\"oai\":{\"pduSessionTypes\":{ \"defaultSessionType\": \"IPV4\"},\"sscModes\": {\"defaultSscMode\": \"SSC_MODE_1\"},\"5gQosProfile\": {\"5qi\": 6,\"arp\":{\"priorityLevel\": 1,\"preemptCap\": \"NOT_PREEMPT\",\"preemptVuln\":\"NOT_PREEMPTABLE\"},\"priorityLevel\":1},\"sessionAmbr\":{\"uplink\":\"100Mbps\", \"downlink\":\"100Mbps\"}}}'); " oai_db-basic.sql


cd -
helm dependency update

#deployment
helm spray .



