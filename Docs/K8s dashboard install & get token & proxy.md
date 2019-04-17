If you have everything working go to this link: http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview . 

1. Install a dashboard:
```kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml```
2. Get token using this guide:
https://github.com/kubernetes/dashboard/wiki/Creating-sample-user#create-service-account
It is only need to create 2 recources and get a token
3. Run `kubectl proxy`
4. Go to link and use token to login.
