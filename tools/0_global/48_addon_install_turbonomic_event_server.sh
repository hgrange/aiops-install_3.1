# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# Install Script for Turbonomic WAIOPS Gateway
#
# V3.1.1
#
#
# ©2021 nikh@ch.ibm.com
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"

source ./tools/0_global/99_config-global.sh
__getClusterFQDN
__getInstallPath

# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# Do Not Edit Below
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"



# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Install Turbonomic WAIOPS Gateway
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
header1Begin "Install Turbonomic WAIOPS Gateway" "rocket"


        oc apply -n default -f ./tools/10_turbonomic/turbo-gateway/create-turbo-gateway.yaml

        echo ""
        echo ""


header1End "Install Turbonomic WAIOPS Gateway" "rocket"



exit 1
# Delete Turbonomic WAIOPS Gateway

oc delete -n default -f ./tools/10_turbonomic/turbo-gateway/create-turbo-gateway.yaml
