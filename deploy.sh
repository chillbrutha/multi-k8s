docker build -t kylemartincollins/multi-client:latest -t kylemartincollins/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kylemartincollins/multi-server:latest -t kylemartincollins/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kylemartincollins/multi-worker:latest -t kylemartincollins/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kylemartincollins/multi-client:latest
docker push kylemartincollins/multi-server:latest
docker push kylemartincollins/multi-worker:latest

docker push kylemartincollins/multi-client:$SHA
docker push kylemartincollins/multi-server:$SHA
docker push kylemartincollins/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kylemartincollins/multi-server:$SHA
kubectl set image deployments/client-deployment client=kylemartincollins/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kylemartincollins/multi-worker:$SHA