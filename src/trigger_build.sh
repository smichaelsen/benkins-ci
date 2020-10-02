#!/usr/bin/env sh

echo "\nBuilding ${BRANCH} with image ${IMAGE}."

# copy bekins resources into workspace
mkdir -p ${LOCAL_WORKSPACE}/benkins
cp ci-build-script.sh ${LOCAL_WORKSPACE}/benkins/
cp keys/key ${LOCAL_WORKSPACE}/benkins/

# start worker
container_name=benkins_worker
if [ $(docker ps -a -f "name=${container_name}" --format '{{.Names}}') == ${container_name} ]; then
  docker start ${container_name}
else
  docker run -d -v ${LOCAL_WORKSPACE}:/workspace --name ${container_name} -w /workspace $IMAGE
fi
docker exec -e "BRANCH=${BRANCH}" -ti benkins_worker sh benkins/ci-build-script.sh
docker stop ${container_name}
