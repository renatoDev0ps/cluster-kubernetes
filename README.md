# Kubernetes

##### Installing kubernetes:

##### Configure your development environment, run install.sh, this contains all prerequisites:
```sh
$ bash install.sh
```
##### Initialize cluster kubernetes
```sh
$ sudo kubeadm init --pod-network-cidr=10.244.0.0/16
```
#### Configure client kubernetes
##### Create a new directory, copy admin.conf and change directory owner
```sh
$ mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
###### obs: Never copy "$" and "|".
.
##### Basic commands for testing
```sh
$ kubectl cluster-info | show cluster informations
$ kubectl get nodes | show nodes in cluster
$ kubectl get all | show all (cluster, nodes, pods, services, replicasets)
```
#### Start minikube:
```sh
$ minikube start
$ minikube ip | show external cluster ip
```
#### Now you can start deploying the pods.
##### Deploy PostgreSQL and PgAdmin4:
```sh
$ kubectl create -f postgresql/postgres-config.yaml | set database credentials
$ kubectl create -f postgresql/postgres-workload.yaml | create pods, services, deployment
$ kubectl create -f postgresql/pgadmin-workload.yaml | create pods, services, deployment
```
##### Check the service:
```sh
$ kubectl get all | show all services
$ kubectl logs pods <pod name> | displays logs for a specific pod
```
###### Obs: Get service ip bind to access pgadmin4 in borwser
.
##### Deploy WikiJS:
```sh
$ kubectl create -f wikijs/wiki-deployment.yaml | create pods, services, deployment
$ kubectl create -f wikijs/wiki-ingress.yaml | create server nginx for comunication http
```
##### Check the service:
```sh
$ kubectl get all | show all services
$ kubectl logs pods <pod name> | displays logs for a specific pod
```
###### Obs: Get service ip bind to access wikiJS in borwser
.
#### To run rocketchat we will use HELM, which was installed along with the prerequisites:
##### To start rocket chat use the commands below:
```sh
$ helm install --set mongodb.mongodbUsername=rocketchat,mongodb.mongodbPassword=rocketchat123,mongodb.mongodbDatabase=rocketchat,mongodb.mongodbRootPassword=root rocketchat stable/rocketchat | provisioning all rocketchat cluster

$ kubectl port-forward --namespace default $(kubectl get pods --namespace default -l "app.kubernetes.io/name=rocketchat,app.kubernetes.io/instance=rocketchat" -o jsonpath='{ .items[0].metadata.name }') 8888:3000 | create bind to the port 3000
```