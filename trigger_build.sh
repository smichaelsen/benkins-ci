source .env

# clear workspace
rm -rf workspace

# checkout project in workspace
git clone -b $BRANCH --depth 1 $REPOSITORY_URL workspace

# copy ci build script into workspace
cp ci-build-script.sh workspace/

# start worker
docker run -d -v $PWD/workspace:/workspace --name benkins_worker -w /workspace $IMAGE
docker exec -e "BRANCH=${BRANCH}" -ti benkins_worker sh ci-build-script.sh
docker stop benkins_worker
docker rm benkins_worker
