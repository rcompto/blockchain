echo 'Iniciando a chaincode..'
sudo docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.foxconn.com.br/users/Admin@org1.foxconn.com.br/msp" cli peer chaincode install -n mycc -v 1.0 -p "/opt/gopath/src/github.com/newcc" -l "node"

sudo docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.foxconn.com.br/users/Admin@org1.foxconn.com.br/msp" cli peer chaincode instantiate -o orderer.foxconn.com.br:7050 -C foxconn -n mycc -l "node" -v 1.0 -c '{"Args":[]}'

echo 'Iniciando a Chaincode...Aguarde uns 10 segundos..'

sleep 10

echo 'Adicionando uma amostrar a mão'

sudo docker exec -e “CORE_PEER_LOCALMSPID=Org1MSP” -e “CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.foxconn.com.br/users/Admin@org1.foxconn.com.br/msp” cli peer chaincode invoke -o orderer.foxconn.com.br:7050 -C foxconn -n mycc -c '{"function":"addMarks","Args":["Temp1","68"]}'

sleep 3
echo 'Consultando;.. TEMP1'

sudo docker exec -e “CORE_PEER_LOCALMSPID=Org1MSP” -e “CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.foxconn.com.br/users/Admin@org1.foxconn.com.br/msp” cli peer chaincode invoke -o orderer.foxconn.com.br:7050 -C foxconn -n mycc -c '{"function":"queryMarks","Args":["Temp1"]}'