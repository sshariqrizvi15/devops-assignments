# kubernetes

- Setup a basic cluster on AWS using KubeAdm
- Master Node, Attach Worker nodes, networking (Calico or anyone, Weaver), etcd,
- Application deployment, Service expose.

## Steps needed to create an environment

sudo apt-get update

sudo apt-get install -y apt-transport-https

sudo su -

 curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add
 
 cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
 
 > deb http://apt.kubernetes.io/ kubernetes-xenial main
 
 > EOF
 
 
 apt-get update
 
 apt-get install -y docker.io
 
 apt-get install -y kubelet kubeadm kubectl kubernetes-cni


kubeadm init

exit

kubectl get node

mkdir -p $HOME/.kube

 sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
 
 sudo chown $(id -u):$(id -g) $HOME/.kube/config
 
 
kubectl get node

kubectl get pods --all-namespaces


### Installing a CNI Network.

sudo su -

sysctl net.bridge.bridge-nf-call-iptables=1

export kubever=$(kubectl version | base64 | tr -d '\n')

kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$kubever"

exit

kubectl get nodes

### install worker nodes, the first node
 sudo su -
 
 kubeadm join --token 844a02.ed299ddcbe17430a 172.31.49.128:6443 --discovery-token-ca-cert-hash sha256:17463c630785dd8685fdd7531389382ce302644db6c329197e20e271aab0bf32
 

kubectl get nodes

 
 kubectl get pods --all-namespaces
 
 
 ### Join the second node to the Cluster. ssh into the slave node.
 
 sudo su -
 
 kubeadm join --token 844a02.ed299ddcbe17430a 172.31.49.128:6443 --discovery-token-ca-cert-hash sha256:17463c630785dd8685fdd7531389382ce302644db6c329197e20e271aab0bf32
 
 kubectl get nodes
 
 kubectl get pods --all-namespaces
 
 
 kubectl create -f helloworld.yml
 
 kubectl create -f helloworld-nodeport-service.yml

