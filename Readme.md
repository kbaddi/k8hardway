#K8s Setup

## Setting up K8s with kubeadm

After installing docker, kubectl, kubeapi, kubeadm 

## Initialize kubeadm 
sudo kubeadm init --pod-network-cidr=192.168.0.0/16

## Configure kubectl

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

## Install calico
kubectl apply -f https://docs.projectcalico.org/v3.7/manifests/calico.yaml