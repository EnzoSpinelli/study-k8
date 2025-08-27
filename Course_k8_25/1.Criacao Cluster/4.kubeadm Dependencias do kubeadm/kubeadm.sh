Containers Runtimes - signfica que é o cara responsável por gerenciar e executar os conteineres nos nós do cluster, ecarregado de tarefas como baixar imagens de conteinres, inicar, parar e monitorar

"Containerd"

https://kubernetes.io/docs/setup/production-environment/container-runtimes/#containerd-systemd
https://docs.docker.com/engine/install/ubuntu/







#############
No terminal #
#############

######################################
Habilitando o IPV4 packet forwarding #
######################################


-------------------------------------------------------------------
# sysctl params required by setup params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system
-------------------------------------------------------------------

sysctl -a | grep ip_forward












################
cgroup drivers #   tanto o kubelet quanto o containerd precisam usar o mesmo drive
################







systemctl status   ( veremos que é do systemd )

--------------------------------------------------------------------
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
-----------------------------------------------------------------------

apt search containerd
apt install containerd.io -y
cd /etc/containerd
ls  ( teremos um config.toml )
containerd config default
containerd config default > /etc/containerd/config.toml
systemctl restart containerd










####################################
Install Kubeadm, kubelet e kubectl # Kubeadm que é a linha de comando para confgurar o cluster, kubelet que é o agente que rodará em cada node, e o kubectl que é nossa ferramenta cliente que interagiremos com o cluster após ele estar pronto  
####################################



cat /proc/swaps 
swapoff

------------------------------------------
sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl gpg


# If the directory `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
# sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg


# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list


sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl


sudo systemctl enable --now kubelet

---------------------------------------------









