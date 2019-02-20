Kubernetes, helm and helmfile how-to-use giude
==============================================

Pre-requisites:
===============

Firs, you need to have all this stuff installed on your workstation:

kubectl, helm, helmfile

Required env vars:
==================
```bash
KUBECONFIG=/Users/kkin/.kube/kubeconfig-multitenant  # Used to setup k8s

AWS_DEFAULT_REGION=us-west-2  # used for helmfile, so it can download charts from AWS S3 private repo

HELMFILE_CLUSTER=test_cluster  # Current cluster, you are working with

TILLER_NAMESPACE=web-service-tiller  # current Tiller namespace
```

Kubernetes setup (TODO!)
========================
(TODO!) This section has only tips, also there is config example in scripts folder  
In few words:
- create config file in .kube folder `kubeconfig-%clustername%`
- create 2 namespaces `web-service` and `web-service-tiller`

**Tip** You should not just copy-paste `kubeconfig-k8scluster`, but
**also change namespace to yours**.

**Note!** Change `KUBECONFIG` var to a full file path, because in relative
way it may not work


So now, when you have set up k8s, you can get all pods in your
namespace:

`kubectl get pods`

Helm setup
==========

Actually I don\'t remember when you should export `HELMFILE_CLUSTER`
env var, so, let\'s just export it now.

In k8s setup step, you should have created a namespace for your service
(web-service) and separate namespace for helm Tiller
(web-service-tiller)

First, you need to install tiller into your namespace:

`helm init --tiller-namespace web-service-tiller`

If you don\'t want to add `--tiller-namespace
web-service-tiller` for every time you call helm or helmfile,
you should export `TILLER_NAMESPACE` env var with name of your Tiller
namespace.

Here is a link to [helm github page](https://github.com/helm/helm) and
[helm charts github page](https://github.com/helm/charts).


Now you can install some helm charts:

`helm install web-service --name
web-service`

Now, in order to reuse that helm charts, you need an helmfile.

Helmfile setup
==============

In order to reuse a AWS charts repository, you need to add this section
to helmfile.yaml

repositories:

```yaml
- name: s3-bucket

url: s3://s3-helm-repository/charts
```

In order to be able to download charts from s3 bucket, you need to
export `AWS_DEFAULT_REGION` env var. I know that S3 is a global
resource, but if env var not set - you will get `missingRegion helm S3
module error`.

**Also!** After you have applied a helmfile and deleted it, and try
again to apply it, you probably can get and `helm diff module error`.  
To get rid of it you should purge delete helmfile:

`helmfile delete --purge`

Helpful scripts (you can find them in scripts folder):
================

#### Helm delete all charts releases

`helm ls --short | xargs -L1 helm delete`

#### Container log. Pass a parameter to grep a name.

```bash
# Use it like this: 
# ./logs.sh promot
websservicepod=$(kubectl get pods -o jsonpath="{.items[*].metadata.name}" | xargs -n 1 | grep $1 | awk '{print $1;}')
echo $websservicepod
kubectl logs -f $websservicepod
```

#### kubectl shortcuts

```bash
# delete an kubernetes entity 
# ./del.sh pod.yaml
kubectl delete -f $1

# create an kubernetes entity 
# ./create.sh pod.yaml
kubectl create -f $1

 # list all pods
kubectl get pods

 # list all services
kubectl get svc

```
