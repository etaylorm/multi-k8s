docker build -t etaylorm/multi-client:latest -t etaylorm/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t etaylorm/multi-server:latest -t etaylorm/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t etaylorm/multi-worker:latest -t etaylorm/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push etaylorm/multi-client:latest
docker push etaylorm/multi-server:latest
docker push etaylorm/multi-worker:latest
docker push etaylorm/multi-client:$SHA
docker push etaylorm/multi-server:$SHA
docker push etaylorm/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=etaylorm/multi-server:$SHA
kubectl set image deployments/client-deployment client=etaylorm/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=etaylorm/multi-worker:$SHA