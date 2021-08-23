[ec2-user@ip-192-0-1-200 ~]$ helm install my-release --set "password=${REDIS_PASSWORD},cluster.nodes=7,cluster.update.addNodes=true,cluster.update.currentNumberOfNodes=6"bitnami/redis-cluster

NAME: my-release
LAST DEPLOYED: Mon Jan  4 12:37:09 2021
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
** Please be patient while the chart is being deployed **


To get your password run:
    export REDIS_PASSWORD=$(kubectl get secret --namespace default my-release-redis-cluster -o jsonpath="{.data.redis-password}" | base64 --decode)

You have deployed a Redis Cluster accessible only from within you Kubernetes Cluster.INFO: The Job to create the cluster will be created.To connect to your Redis cluster:

1. Run a Redis pod that you can use as a client:
kubectl run --namespace default my-release-redis-cluster-client --rm --tty -i --restart='Never' \
 --env REDIS_PASSWORD=$REDIS_PASSWORD \
--image docker.io/bitnami/redis-cluster:6.0.9-debian-10-r36 -- bash

2. Connect using the Redis CLI:

redis-cli -c -h my-release-redis-cluster -a $REDIS_PASSWORD
[ec2-user@ip-192-0-1-200 ~]$
[ec2-user@ip-192-0-1-200 ~]$




helm install --timeout 600s my-release --set "password=password,cluster.nodes=3,persistence.size=22Gi" bitnami/redis-cluster
helm upgrade --timeout 600s my-release --set "password=password,cluster.nodes=4,cluster.update.addNodes=true,cluster.update.currentNumberOfNodes=3" bitnami/redis-cluster
