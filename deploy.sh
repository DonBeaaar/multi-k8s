docker build -t bearshadow/multi-client:latest -t bearshadow/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bearshadow/multi-server:latest -t bearshadow/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bearshadow/multi-worker:latest -t bearshadow/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bearshadow/multi-client:latest
docker push bearshadow/multi-server:latest
docker push bearshadow/multi-worker:latest

docker push bearshadow/multi-client:$SHA
docker push bearshadow/multi-server:$SHA
docker push bearshadow/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bearshadow/multi-server:$SHA
kubectl set image deployments/client-deployment client=bearshadow/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bearshadow/multi-worker:$SHA