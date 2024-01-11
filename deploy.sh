docker build -t mgh1990/multi-client:latest -t mgh1990/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mgh1990/multi-server:latest -t mgh1990/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mgh1990/multi-worker:latest -t mgh1990/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mgh1990/multi-client:latest
docker push mgh1990/multi-server:latest
docker push mgh1990/multi-worker:latest
docker push mgh1990/multi-client:$SHA
docker push mgh1990/multi-server:$SHA
docker push mgh1990/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=mgh1990/multi-server:$SHA
kubectl set image deployments/client-deployment client=mgh1990/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mgh1990/multi-worker:$SHA