Creating a cluster with kubeadm 
https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/


Bootstrap é apenas na Master
#############
No terminal #
#############




kubeadm --help
kubeadm init --help ( quem inicia o control plane )
ip a
kubeadm init --apiserver-advertise-address 172.89.0.11 --pod-network-cidr 10.244.0.0/16   ( usando o flannel )

#####################################
Após finalizar a criação do cluster #
#####################################

export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl get pods -A


######################
Para Debugar os pods #
######################

crictl ps
crictl logs -f (id)




######################################################################################################
Se os pods não iniciarem provavelmente é conflito entre o drive do kubectl e o containerd            #
Se estivermos utilizando o systemd é interessante utilizar o V2 mas podemos confirmar com o comando= #
######################################################################################################

mount | grep cgroup
vim /etc/cibtauberd/config.toml
/SystemdCgr


############################################################
Se ele estiver como false, estará utilizando a V1          #
Então apertamos "a" e apagamos o false e trocamos por True #
############################################################


systemctl restart containerd
systemctl status containerd




kubeadm reset  ( será apagado tudo do nosso cluster )
y
export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl get pods -A     ( é para mostrar mensagem de erro pois foi deletado o cluster )




#######################################################################################################################
Ao invés de colocarmos toda a configuração na própria linha de comando, podemos criar um yaml contendo as informações #
#######################################################################################################################

###################################################################################
São 3 configurações:                                                              #
Advertise vai ser na 172.89.0.11                                                  #
a configuração do cluster vai ser utilizar da rede de pods na 10.244.0.0/16       #
e o driver que iremos utilizar é o systemd                                        #
###################################################################################


                        YML=
______________________________________________________
                                                     |
cat > kubeadm-config.yml <<EOF

apiVersion: Kubeadm.k8s.io/v1beta4
kind: InitConfiguration
localAPIEndpoint:
  advertiseAddress: 172.89.0.11
  bindPort: 6443
---
apiVersion: Kubeadm.k8s.io/v1beta4
kind: ClusterConfiguration
networking:
  podSubnet: 10.244.0.0/16
---
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
cgroupDriver: systemd
EOF

_____________________________________________________|

ls
cat kubeadm-config.yml 
kubeadm init --config kubeadm-config.yml
export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl get pods -A

##############################
Agora, todos devem estar 1/1 #
##############################











