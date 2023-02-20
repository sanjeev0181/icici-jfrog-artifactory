#/bin/bash
echo "/root/.jenkins/workspace/icici-build-sonartest-docker/target/"
cd /root/.jenkins/workspace/icici-build-sonartest-docker/target/
echo "ls -lrt"
ls -lh 
artifact_file_name=`ls *.war`
echo "file name: $artifact_file_name"
curl -u jenkins -pChandra@2835 -X PUT "http://15.206.73.130:8081/artifactory/libs-snapshot/$JOB_NAME/$artifact_file_name" -T $artifact_file_name

