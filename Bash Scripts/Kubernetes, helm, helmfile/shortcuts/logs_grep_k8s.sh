# promotionsservicepod=$(kubectl get pods -o jsonpath="{.items[*].metadata.name}" | grep promotion | awk '{print $1;}')
promotionsservicepod=$(kubectl get pods -o jsonpath="{.items[*].metadata.name}" | xargs -n 1 | grep $1 | awk '{print $1;}')
echo $promotionsservicepod
kubectl logs -f $promotionsservicepod
