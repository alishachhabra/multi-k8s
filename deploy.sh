docker build -t alisha0788/multi-client-k8s:latest -t alisha0788/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t alisha0788/multi-server-k8s-pgfix:latest -t alisha0788/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t alisha0788/multi-worker-k8s:latest -t alisha0788/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push alisha0788/multi-client-k8s:latest
docker push alisha0788/multi-server-k8s-pgfix:latest
docker push alisha0788/multi-worker-k8s:latest

docker push alisha0788/multi-client-k8s:$SHA
docker push alisha0788/multi-server-k8s-pgfix:$SHA
docker push alisha0788/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alisha0788/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=alisha0788/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=alisha0788/multi-worker-k8s:$SHA