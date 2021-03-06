# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# Install Script for Instana
#
# V3.1.1
#
# https://www.instana.com/docs/self_hosted_instana_k8s/installation
#
# ©2021 nikh@ch.ibm.com
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"

source ./tools/0_global/99_config-global.sh

# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# Do Not Edit Below
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"

#headerModuleFileBegin "Install Instana " $0

# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# INSTALL CHECKS
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
header3Begin "Install Instana"


        getInstallPath


        checkAlreadyInstalled app=Instana default
        if [[ $ALREADY_INSTALLED == 1 ]];
        then
            __output "    ⭕ Instana already installed! Skipping..."

            #headerModuleFileEnd "Install Open LDAP " $0
            exit 0
        else
            __output "      ✅ OK"
        fi

header3End



# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# PREREQUISITES
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
header3Begin "Running Prerequisites" "rocket"

        export SCRIPT_PATH=$(pwd)
        __output "      ✅ OK"

header3End



# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Install Instana
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
header3Begin "Install Instana" "rocket"


      __output "Install Instana"

       openssl req -x509 -newkey rsa:2048 -keyout tls.key -out tls.crt -days 365 -nodes -subj "/CN=ibm.com"
openssl genrsa -aes128 -out saml_key.pem 2048
openssl req -new -x509 -key saml_key.pem -out saml_cert.pem -days 365
cat saml_key.pem saml_cert.pem > saml_key_cert.pem

        __output "      ✅ Instana Installed"
header3End


exit 1
        kubectl delete -f ./yaml/turbonomic/crds/charts_v1alpha1_xl_cr.yaml -n turbonomic

        kubectl delete -f ./yaml/turbonomic/service_account.yaml -n turbonomic
        kubectl delete -f ./yaml/turbonomic/role.yaml -n turbonomic
        kubectl delete -f ./yaml/turbonomic/role_binding.yaml -n turbonomic
        kubectl delete -f ./yaml/turbonomic/crds/charts_v1alpha1_xl_crd.yaml
        kubectl delete -f ./yaml/turbonomic/operator.yaml -n turbonomic


kubectl delete ns turbonomic

      oc adm policy add-scc-to-group anyuid system:serviceaccount:turbonomic:t8c-operator

oc create clusterrolebinding test-admin --clusterrole=cluster-admin --serviceaccount=turbonomic:t8c-operator
oc adm policy add-role-to-user cluster-admin system:serviceaccount:turbonomic:t8c-operator --role-namespace=turbonomic -n turbonomic

#headerModuleFileEnd "Install Instana " $0

grafana

cat /dev/zero | head -c 5G | tail

cat /dev/zero | head -c 5000m | tail


oc apply -n default -f ./tools/6_bastion/create-bastion.yaml

apt-get install htop
apt-get install stress-ng
stress-ng --cpu 20 --cpu-load 99 --vm 20 --vm-bytes 99% -t 150m



