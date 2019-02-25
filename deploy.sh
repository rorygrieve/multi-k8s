docker build -t psicorpgmbh/multi-client:latest -t psicorpgmbh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t psicorpgmbh/multi-server:latest -t psicorpgmbh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t psicorpgmbh/multi-worker:latest -t psicorpgmbh/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push psicorpgmbh/multi-client:latest
docker push psicorpgmbh/multi-server:latest
docker push psicorpgmbh/multi-worker:latest

docker push psicorpgmbh/multi-client:$SHA
docker push psicorpgmbh/multi-server:$SHA
docker push psicorpgmbh/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=psicorpgmbh/multi-client:$SHA
kubectl set image deployments/server-deployment server=psicorpgmbh/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=psicorpgmbh/multi-worker:$SHA
