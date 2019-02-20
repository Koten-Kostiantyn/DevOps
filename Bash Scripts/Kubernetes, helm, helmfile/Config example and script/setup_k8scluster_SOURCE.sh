# execute it like this: "source this_script.sh"
# this file is supposed to be in /Users/{$USER}/.kube/ folder

export KUBECONFIG="/Users/{$USER}/.kube/kubeconfig-k8scluster" 
kubectl config use-context k8scluster
export TILLER_NAMESPACE=web-service-tiller
export AWS_DEFAULT_REGION=us-west-2  # used for helmfile, so it can download charts from AWS S3 private repo
export HELMFILE_CLUSTER=k8scluster  # Current cluster, you are working with