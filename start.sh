#!/bin/bash
cd /home/developer/workspace/springCloudExample/discovery-server/target
nohup java -jar discovery-server-0.0.1-SNAPSHOT.jar >/dev/null 2>&1 &
sleep 5

cd /home/developer/workspace/springCloudExample/service-example/target
nohup java -jar -Dserver.port=9091 -Dservice.instance.name=intance1 service-example-0.0.1-SNAPSHOT.jar >/dev/null 2>&1 &
sleep 5

nohup java -jar -Dserver.port=9092 -Dservice.instance.name=intance2 service-example-0.0.1-SNAPSHOT.jar >/dev/null 2>&1 &
wait



