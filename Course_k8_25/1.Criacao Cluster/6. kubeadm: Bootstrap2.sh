#############################################################################################
Nosso cluster está estável porém se executarmos um=                                         #
"     kubectl get pods -A -o wide     "                                                     #
Veremos que o endereço IP é o endereço IP de nat do node e não temos o endereço Ip dos pods #
"Na documentação estamos falando da parte de Installing a POD Network add-on, no nosso caso"#
"utilizaremos o flannel "                                                                   #
https://github.com/flannel-io/flannel                                                       #
#############################################################################################



kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
kubectl get pods -n kube-flannel
kubectl logs -n kube-flannel (nome do pod)



###########################################################################################################################
Provavelmente estará com erro, e ao entrar nos logs, veremos que está faltando um módulo do kernel chamado "br_netfilter" #
###########################################################################################################################



lsmod | grep br_            ( nao teremos esse modulo em memoria )
modprobe br_netfilter
lsmod | grep br_
kubectl get pods -n kube-flannel
kubectl delete pod -n kube-flannel (nome do pod)
kubectl get pods -n kube-flannel
kubectl get pods -n kube-flannel -w
kubectl logs -n kube-flanel (nome do pod)




###############################################################################
Qual o problema agora ? O módulo não será startado após o reinicio da máquina #
Para evitar isso...                                                           #
###############################################################################



echo "br_netfilter" >> /etc/modules-load.d/modules.conf           ( nos workers e master )
cat /etc/modules-load.d/modules.conf 
modprobe br_netfilter         ( nos workers )
lsmod | grep br_          ( nos workers )


kubectl get pods -A       ( na master )
kubectl get node           ( único node que mostrará é o do master )




####################################################################################
Como adicionar nodes dos workers na master ? Ao fazer o bootstrap, tem uma saida=  #
"kubeadm join (ip) --token (token) \                                               #
   --discovery-token-ca-cert-hash sha256:(hash) "                                  #
Mas podemos ter esse token de outra forma também:                                  #
####################################################################################

kubeadm --help
kubeadm  token create --help
kubeadm token create --print-join-command                 ( assim, irá ser printado o comando do token )






#############################################################
Nos workers, iremos adicionar o token que acabamos de pegar #
#############################################################

kubeadm join (ip) --token-(token) --discovery-token...(hash)

#####################################################################################################################################################################
Caso de algum erro ao utilizar novamente o Token em outro worker, rode novamente o comando do token create na master e pegue esse novo Token e rode no outro worker #
#####################################################################################################################################################################






####################################
Na master, vamos conferir os nodes #
####################################

kubectl get nodes -w
kubectl get nodes -A












