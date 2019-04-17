`kubectl edit cm aws-auth -n kube-system`
Example
```yaml
# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
apiVersion: v1
data:
  mapAccounts: ""
  mapRoles: |
    - rolearn: arn:aws:iam::373353083651:role/bridge-eks-stage-120190306165522094900000007
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
    - rolearn: arn:aws:iam::373353083651:role/jenkins-build-server
      username: jenkins-build-server
      groups:
        - system:masters
    - rolearn: arn:aws:iam::373353083651:role/KubernetesAdmin
      username: admin
      groups:
        - system:masters
  mapUsers: |
    - userarn: arn:aws:iam::373353083651:user/Konstantin
      username: kkin
      groups:
        - system:masters
    - userarn: arn:aws:iam::373353083651:user/dmcdermott
      username: dmcdermott
      groups:
        - system:masters
kind: ConfigMap
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","data":{"mapAccounts":"","mapRoles":"- rolearn: arn:aws:iam::373353083651:role/bridge-eks-stage-120190306165522094900000007\n  username: system:node:{{EC2PrivateDNSName}}\n  groups:\n    - system:bootstrappers\n    - system:nodes\n","mapUsers":""},"kind":"ConfigMap","metadata":{"annotations":{},"name":"aws-auth","namespace":"kube-system"}}
  creationTimestamp: 2019-03-07T08:08:40Z
  name: aws-auth
  namespace: kube-system
  resourceVersion: "6200245"
  selfLink: /api/v1/namespaces/kube-system/configmaps/aws-auth
  uid: 3803ecde-40b0-11e9-82ea-0a27d5912cd4
```
