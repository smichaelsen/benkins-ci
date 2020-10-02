#!/usr/bin/env sh

echo "\nBuilding ${BRANCH} with image ${IMAGE}."

# copy bekins resources into workspace
mkdir -p ${LOCAL_WORKSPACE}/benkins
cp ci-build-script.sh ${LOCAL_WORKSPACE}/benkins/
cp keys/key ${LOCAL_WORKSPACE}/benkins/

# start worker
docker run -d -v ${LOCAL_WORKSPACE}:/workspace --name benkins_worker -w /workspace $IMAGE
docker exec -e "BRANCH=${BRANCH}" -ti benkins_worker sh benkins/ci-build-script.sh
docker stop benkins_worker
docker rm benkins_worker
