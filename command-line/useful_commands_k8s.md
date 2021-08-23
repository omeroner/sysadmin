### get contexts
```sh
kubectl config get-contexts
```
### get pod
```sh
kubectl get pod
```

### get namespace
```sh
kubectl get ns
```

### print out a pod logs (https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs)
```sh
kubectl logs {name_of_pod} -n {namespace} --since=2h --timestamps
```

### print the logs for the _previous_ instance of the container in a pod if it exists
```sh
kubectl logs -p {name_of_pod} -n {namespace} --since=2h --timestamps
```
### check events (https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#describe)
```sh
kubectl describe pod {pod_name} -n {namespace}
```

### observe all events (https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get)
```sh
kubectl get events -n {namespace} --sort-by=.metadata.creationTimestamp
```

### check logs, etc. in pod container (https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec)
```sh
kubectl exec -it {pod_name} -n {namespace} -- sh
```
```sh
kubectl get pods --all-namespaces -o json | jq '.items[] | select(.status.reason!=null) | select(.status.reason | contains("Evicted")) | "kubectl delete pods \(.metadata.name) -n \(.metadata.namespace)"' | xargs -n 1 bash -c
```
```sh
kubectl -n default delete pods --field-selector=status.phase=Failed
```
```sh
kubectl get pods --all-namespaces --field-selector 'status.phase==Failed' -o json | kubectl delete -f -
```
```sh
kubectl get pod -n studytonight | grep Evicted | awk '{print $1}' | xargs kubectl delete pod -n studytonight
```
```sh
while true; do kubectl delete -n default pod redis-master-0; sleep 4; done
```
```sh
kubectl cp default/schedule-api-deployment-6fb5f74c77-rmt2l:/go/src/pts-api/public/profiles /home/admin/
scp -r -i /Users/omeroner/Documents/Lingaros/pem-files/stagelinga.pem ubuntu@52.8.19.27:/home/ubuntu/pvc  /Users/omeroner
```

```sh
1- Staging cluster'da 3. node da kullanılmıyordu. 

Taints:  NodeWithImpairedVolumes=true:NoSchedule vardı

admin@ip-172-20-37-80:~$ kubectl taint nodes ip-172-20-58-49.us-west-1.compute.internal NodeWithImpairedVolumes:NoSchedule-
node "ip-172-20-58-49.us-west-1.compute.internal" untainted
```
