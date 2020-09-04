#!/usr/bin/env sh

echo "\nBuilding ${BRANCH} with image ${IMAGE}."

# copy ci build script into workspace
cp ci-build-script.sh ${LOCAL_WORKSPACE}/

# start worker
docker run -d -v ${LOCAL_WORKSPACE}:/workspace --name benkins_worker -w /workspace $IMAGE
docker exec -e "BRANCH=${BRANCH}" -ti benkins_worker sh ci-build-script.sh
docker stop benkins_worker
docker rm benkins_worker
