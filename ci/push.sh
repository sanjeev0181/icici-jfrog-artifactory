#/bin/bash
echo "/root/.jenkins/workspace/icici-build-sonartest-docker/target/"
cd /root/.jenkins/workspace/icici-build-sonartest-docker/target/
echo "ls -lrt"
ls -lh 
artifact_file_name=`ls *.war`
echo "file name: $artifact_file_name"
curl -u${ARTIFACTORY_USER}:${ARTIFACTORY_PASSWORD} -X PUT "http://3.108.41.50:8081/artifactory/libs-snapshot/$JOB_NAME-$artifact_file_name" -T $artifact_file_name

