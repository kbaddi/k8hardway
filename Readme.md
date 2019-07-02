#K8s Setup

## Terraform Setup

Before you run docker-compose, ensure you export Azure Service Principal credentials
export ARM_CLIENT_ID=<Azure_CLIENT_ID>
export ARM_CLIENT_SECRET=<Azure_CLIENT_SECRET>
export ARM_SUBSCRIPTION_ID=<Azure_Subscription_ID>
export ARM_TENANT_ID=<Azure_Tenant_ID>

## Setting up K8s with kubeadm

After installing docker, kubectl, kubeapi, kubeadm

- Initialize kubeadm
  sudo kubeadm init --pod-network-cidr=192.168.0.0/16

- Configure kubectl
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

- Install calico
  kubectl apply -f https://docs.projectcalico.org/v3.7/manifests/calico.yaml
