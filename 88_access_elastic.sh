#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# ADAPT VALUES in ./01_config.sh
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# DO NOT EDIT BELOW
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

source ./tools/0_global/99_config-global.sh





echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo " ???? AI OPS DEBUG - Enable ElastcSearch remote access"
echo "***************************************************************************************************************************************************"

echo "  Initializing......"







#--------------------------------------------------------------------------------------------------------------------------------------------
#  Get Credentials
#--------------------------------------------------------------------------------------------------------------------------------------------

echo "***************************************************************************************************************************************************"
echo "  ????  Getting credentials"
echo "***************************************************************************************************************************************************"
oc project $WAIOPS_NAMESPACE >$log_output_path 2>&1  || true


export username=$(oc get secret $(oc get secrets | grep ibm-elasticsearch-secret | awk '!/-min/' | awk '{print $1;}') -o jsonpath="{.data.username}"| base64 --decode)
export password=$(oc get secret $(oc get secrets | grep ibm-elasticsearch-secret | awk '!/-min/' | awk '{print $1;}') -o jsonpath="{.data.password}"| base64 --decode)



echo "      ??? OK"
echo ""
echo ""





#--------------------------------------------------------------------------------------------------------------------------------------------
#  Check Credentials
#--------------------------------------------------------------------------------------------------------------------------------------------

echo "***************************************************************************************************************************************************"
echo "  ????  Checking credentials"
echo "***************************************************************************************************************************************************"

if [[ $username == "" ]] ;
then
      echo "??? Could not get Elasticsearch Username. Aborting..."
      exit 1
else
      echo "      ??? OK - Elasticsearch Username"
fi

if [[ $password == "" ]] ;
then
      echo "??? Could not get Elasticsearch Password. Aborting..."
      exit 1
else
      echo "      ??? OK - Elasticsearch Password"
fi



echo ""
echo ""
echo ""
echo ""





echo "***************************************************************************************************************************************************"
echo "  ????  ElasticSearch Access"
echo "***************************************************************************************************************************************************"
echo ""
echo "           ???? URL                         : https://localhost:9200"
echo ""
echo "           ????????????? User                        : $username"
echo "           ???? Password                    : $password"
echo ""
echo "            You can use any ElasticSearch Browser. I usually use https://elasticvue.com/"
echo ""
echo "***************************************************************************************************************************************************"
echo ""
echo ""
echo "***************************************************************************************************************************************************"
echo "  ??????  Startting Port Forwarding"
echo "***************************************************************************************************************************************************"
echo ""

while true; do oc port-forward statefulset/elasticsea-cd98-ib-6fb9-es-server-all 9200; done




