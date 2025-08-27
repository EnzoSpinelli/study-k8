Instalando kubernetes com ferramentas de deployment

Algumas formas:

-kubeadm
-Cluster API
-kops
-kubespray



File do Vagrant na pasta ( Vagrant é para criar as máquinas no vitualbox )
Para pegar a imagem vai em "vagrant cloud" e clica em portal.cloud.hashicorp.com
No diretório com o vagrant= 


################
Criando as VMs
################

vagrant up
sudo su
root@pop-os:/home/Paula/STD_KUBERNETS/Course_k8_25/1.Criação Cluster/3.kubeadm Provisioanndo Vms com Vagrant# echo "* 0.0.0.0/0 ::/o* > /etc/vbox/netowrks.conf



#####################
No terminal ( Tilix )
#####################

Dentro do diretório que tem o vagrantfile=
vagrant ssh master-1 ( Para entrarmos no worker )

Em outro terminal=
vagrant ssh master-1 ( Para entrarmos no worker )

Em outro terminal=
vagrant ssh master-2 ( Para entrarmos no master )

sudo apt update ( em todas as máquinas )
sudo apt upgrade -y ( em todas as máquinas )
