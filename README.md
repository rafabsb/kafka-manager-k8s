## Created from: sheepkiller/kafka-manager-docker

# kafka manager Dockerfile
[kafka manager](https://github.com/yahoo/kafka-manager) is a tool from Yahoo Inc. for managing [Apache Kafka](http://kafka.apache.org).
## Base Docker Image ##
* [centos:7](https://hub.docker.com/_/centos/)

## Howto
### Quick Start
This is just a quick and clean install of yahoo/kafka-manager. It should be started in a kubernetes cluster.

Refer to yahoo/kafka-manager for further app configuration.

### Specify a revision
If you want to upgrade/downgrade this Dockerfile, edit it and set `KM_VERSION` and `KM_REVISION` to fetch the release from github.

## Known issues
- release before 1.3.1.6 may have APPLICATION_SECRET incorrectly set (default value) and kafka-manager will fail to start. Remove /kafka-manager znode from zookeeeper and reconfigure kafka-manager.
