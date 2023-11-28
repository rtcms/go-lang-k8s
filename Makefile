build:
	sudo docker build . -t rt007/go-web:latest

run: build
	kubectl apply -f Deployment/deployment.yaml

destroy:
	sudo docker rmi rt007/go-web:latest
	kubectl delete -f Deployment/deployment.yaml
	minikube service webapplication-service --url

client:
	bashclient.sh