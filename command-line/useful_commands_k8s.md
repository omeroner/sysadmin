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

# observe all events (https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get)
```sh
kubectl get events -n {namespace} --sort-by=.metadata.creationTimestamp
```

# check logs, etc. in pod container (https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#exec)
```sh
kubectl exec -it {pod_name} -n {namespace} -- sh
```

