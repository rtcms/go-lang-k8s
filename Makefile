build:
	sudo docker build . -t rt007/go-web:latest -f Dockerfile.server
	sudo docker build . -t rt007/go-web-client:latest -f Dockerfile.client
	cd charts/go-web && helm dependency build

run: build
	cd charts/go-web && helm install go-web .

hpa:
	kubectl get hpa --watch

destroy:
	sudo docker rmi rt007/go-web:latest rt007/go-web-client:latest
	helm uninstall go-web