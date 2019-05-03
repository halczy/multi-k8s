docker build -t halczy/multi-client:latest -t halczy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t halczy/multi-server:latest -t halczy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t halczy/multi-worker:latest -t halczy/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push halczy/multi-client:latest
docker push halczy/multi-client:$SHA
docker push halczy/multi-server:latest
docker push halczy/multi-server:$SHA
docker push halczy/multi-worker:latest
docker push halczy/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment server=halczy/multi-client:$SHA
kubectl set image deployments/server-deployment server=halczy/multi-server:$SHA
kubectl set image deployments/worker-deployment server=halczy/multi-worker:$SHA