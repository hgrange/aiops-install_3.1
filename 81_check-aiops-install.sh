source ./99_config-global.sh

export SCRIPT_PATH=$(pwd)
export LOG_PATH=""
__getClusterFQDN
__getInstallPath

clear

banner 
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "  "
echo "  🚀 CloudPak for Watson AI OPS 3.1"
echo "  "
echo "***************************************************************************************************************************************************"
echo "  "
echo "  "


echo ""
echo ""
echo "--------------------------------------------------------------------------------------------"
echo "✅ Check CP4WAIOPS Installation"
echo "--------------------------------------------------------------------------------------------"


checkCSDone
checkInstallDone



echo ""
echo ""
echo "--------------------------------------------------------------------------------------------"
echo "✅ Check Kafka Topics"
echo "--------------------------------------------------------------------------------------------"




export LOGS_TOPIC=$(oc get KafkaTopic -n $WAIOPS_NAMESPACE | grep logs-humio| awk '{print $1;}')


echo "    🔎 Check derived-stories KafkaTopic" 

TOPIC_READY=$(oc get KafkaTopics -n $WAIOPS_NAMESPACE derived-stories -o jsonpath='{.status.conditions[0].status}' || true)

while  ([[ ! $TOPIC_READY =~ "True" ]] ); do 
    TOPIC_READY=$(oc get KafkaTopics -n $WAIOPS_NAMESPACE derived-stories -o jsonpath='{.status.conditions[0].status}' || true)
    echo "      🕦 wait for derived-stories KafkaTopic" 
    sleep 3
done
echo "       ✅ OK"



echo "    🔎 Check windowed-logs KafkaTopic" 

TOPIC_READY=$(oc get KafkaTopics -n $WAIOPS_NAMESPACE windowed-logs-1000-1000 -o jsonpath='{.status.conditions[0].status}' || true)

while  ([[ ! $TOPIC_READY =~ "True" ]] ); do 
    TOPIC_READY=$(oc get KafkaTopics -n $WAIOPS_NAMESPACE windowed-logs-1000-1000 -o jsonpath='{.status.conditions[0].status}' || true)
    echo "      🕦 wait for windowed-logs KafkaTopic" 
    sleep 3
done
echo "       ✅ OK"


echo "    🔎 Check normalized-alerts KafkaTopic" 

TOPIC_READY=$(oc get KafkaTopics -n $WAIOPS_NAMESPACE normalized-alerts-1000-1000 -o jsonpath='{.status.conditions[0].status}' || true)

while  ([[ ! $TOPIC_READY =~ "True" ]] ); do 
    TOPIC_READY=$(oc get KafkaTopics -n $WAIOPS_NAMESPACE normalized-alerts-1000-1000 -o jsonpath='{.status.conditions[0].status}' || true)
    echo "      🕦 wait for normalized-alerts KafkaTopic" 
    sleep 3
done
echo "       ✅ OK"

echo "    🔎 Check $LOGS_TOPIC KafkaTopic" 

TOPIC_READY=$(oc get KafkaTopics -n $WAIOPS_NAMESPACE $LOGS_TOPIC -o jsonpath='{.status.conditions[0].status}' || true)

while  ([[ ! $TOPIC_READY =~ "True" ]] ); do 
    TOPIC_READY=$(oc get KafkaTopics -n $WAIOPS_NAMESPACE $LOGS_TOPIC -o jsonpath='{.status.conditions[0].status}' || true)
    echo "      🕦 wait for $LOGS_TOPIC KafkaTopic" 
    sleep 3
done
echo "       ✅ OK"


#oc delete pod $(oc get pods | grep event-gateway-generic-evtmgrgw | awk '{print $1;}')



echo ""
echo ""
echo "--------------------------------------------------------------------------------------------"
echo "✅ Check Pods"
echo "--------------------------------------------------------------------------------------------"



echo "    🔎 Check for Anomaly Pod" 

SUCCESFUL_RESTART=$(oc get pods | grep log-anomaly-detector | grep 0/1 || true)

while  ([[ $SUCCESFUL_RESTART =~ "0" ]] ); do 
    SUCCESFUL_RESTART=$(oc get pods | grep log-anomaly-detector | grep 0/1 || true)
    echo "      🕦 wait for Anomaly Pod" 
    sleep 10
done
echo "       ✅ OK"

echo "    🔎 Check for Event Grouping Pod" 

SUCCESFUL_RESTART=$(oc get pods | grep aimanager-aio-event-grouping | grep 0/1 || true)

while  ([[ $SUCCESFUL_RESTART =~ "0" ]] ); do 
    SUCCESFUL_RESTART=$(oc get pods | grep aimanager-aio-event-grouping | grep 0/1 || true)
    echo "      🕦 wait for Event Grouping Pod" 
    sleep 10
done
echo "       ✅ OK"


echo "    🔎 Check for Task Manager Pod" 

SUCCESFUL_RESTART=$(oc get pods | grep flink-task-manager-0 | grep 0/1 || true)

while  ([[ $SUCCESFUL_RESTART =~ "0" ]] ); do 
    SUCCESFUL_RESTART=$(oc get pods | grep flink-task-manager-0 | grep 0/1 || true)
    echo "      🕦 wait for Flink Task Manager Pod" 
    sleep 10
done
echo "       ✅ OK"

echo "    🔎 Check for Gateway Pod" 

SUCCESFUL_RESTART=$(oc get pods | grep event-gateway-generic | grep 0/1 || true)

while  ([[ $SUCCESFUL_RESTART =~ "0" ]] ); do 
    SUCCESFUL_RESTART=$(oc get pods | grep event-gateway-generic | grep 0/1 || true)
    echo "      🕦 wait for Gateway Pod" 
    sleep 10
done
echo "       ✅ OK"



echo ""
echo ""
echo "--------------------------------------------------------------------------------------------"
echo "✅ Check RobotShop Demo (must all be Running 1/1)"
echo "--------------------------------------------------------------------------------------------"


oc get -n robot-shop pods | grep -v shipping




echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo ""
echo " 🚀 DONE - You're good to go!!!!!"
echo ""
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
