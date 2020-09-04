echo "Building ${BRANCH} branch of ${REPOSITORY_URL} with image ${IMAGE}.\n"
echo "Local workspace path: ${LOCAL_WORKSPACE}"

# clear workspace if it is safe
case $LOCAL_WORKSPACE/ in
  $PWD/*) echo "Clearing workspace"; rm -rf $LOCAL_WORKSPACE;;
  *) echo "Local workspace is not safe to delete! Aborting."; exit 200;;
esac

# checkout project in workspace
git clone -b $BRANCH --depth 1 $REPOSITORY_URL $LOCAL_WORKSPACE

# copy ci build script into workspace
cp ci-build-script.sh ${LOCAL_WORKSPACE}/

# start worker
docker run -d -v ${LOCAL_WORKSPACE}:/workspace --name benkins_worker -w /workspace $IMAGE
docker exec -e "BRANCH=${BRANCH}" -ti benkins_worker sh ci-build-script.sh
docker stop benkins_worker
docker rm benkins_worker
