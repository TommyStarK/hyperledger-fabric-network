# hyperledger-fabric-network

Hyperledger Fabric network for demo purposes only

## Usage

```bash
# Generate genesis block, crypto and channel(s) artifacts
❯ ./generate-artifacts.sh

❯ export COMPOSE_PROJECT_NAME=fabric_network

# Boot the network
❯ docker-compose up -d
```

- Go to <http://localhost:5984/_utils> and authenticate with  `root`/`root` to access to the CouchDB backing the peer of `org1`
