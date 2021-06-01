source ./01_config.sh

banner

echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo " 🚀 CP4WAIOPS DELETE NOI EVENTS"
echo "***************************************************************************************************************************************************"
echo " This will reset:"
echo "    - Netcool Events"
echo "***************************************************************************************************************************************************"


  read -p "❗ Are you really, really, REALLY sure you want to delete NOI events for Robotshop? [y,N] " DO_COMM
  if [[ $DO_COMM == "y" ||  $DO_COMM == "Y" ]]; then
    echo "      🧞‍♂️ OK, as you wish...."
  else
    echo "      ❌ Aborted"
    exit 1
  fi
  
# ----------------------------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------------------------
# Reset Demo - Clean Up
# ----------------------------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------------------------
oc project $WAIOPS_NAMESPACE >/dev/null 2>&1

echo "--------------------------------------------------------------------------------------------------------------------------------"
echo "Delete Events"
echo "--------------------------------------------------------------------------------------------------------------------------------"

password=$(oc get secrets | grep omni-secret | awk '{print $1;}' | xargs oc get secret -o jsonpath --template '{.data.OMNIBUS_ROOT_PASSWORD}' | base64 --decode)
oc get pods | grep ncoprimary-0 | awk '{print $1;}' | xargs -I{} oc exec {} -- bash -c "/opt/IBM/tivoli/netcool/omnibus/bin/nco_sql -server AGG_P -user root -passwd ${password} << EOF
delete from alerts.status where AlertGroup='robot-shop';
go
exit
EOF"
echo " ✅ OK"



echo "--------------------------------------------------------------------------------------------------------------------------------"
echo "--------------------------------------------------------------------------------------------------------------------------------"
echo "  ✅ DONE... You're good to go...."
echo "--------------------------------------------------------------------------------------------------------------------------------"
echo "--------------------------------------------------------------------------------------------------------------------------------"
