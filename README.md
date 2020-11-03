## Configure your development environment, run install.sh
```
bash install.sh
```
## Initialize cluster kubernetes
```
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
```
## Configure client kubernetes
### Create a new directory, copy admin.conf and change directory owner
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
### Basic commands for testing
```
kubectl cluster-info | show cluster informations
kubectl get nodes | show nodes in cluster
watch kubectl get all --all-namespaces | show all namespaces in cluster
```
## Configure Pod Networks, use addons Flannel
```
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```
## authorization to master run pods
```
kubectl taint nodes --all node-role.kubernetes.io/master-node/renatodevops untainted
```
