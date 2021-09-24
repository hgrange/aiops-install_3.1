
Create Bastion Pod

```bash
oc apply -n default -f ./tools/8_tool_pod/create-tool-pod.yaml
```

Create Automation

```bash
oc login --token=$token --server=$ocp_url
oc scale deployment --replicas=1 -n bookinfo ratings-v1
```

```yaml
target: bastion-host-service.default.svc
user:   root
$token		
$ocp_url		
```

