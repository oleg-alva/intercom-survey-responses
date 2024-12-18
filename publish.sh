VERSION=$(git rev-parse --short HEAD)
export CLOUDSDK_CORE_DISABLE_PROMPTS=1

DOCKER_REGISTRY_BASE_PRODUCTION="europe-docker.pkg.dev/$2"
DOCKER_IMAGE_PRODUCTION="${DOCKER_REGISTRY_BASE_PRODUCTION}/$1/$1"

gcloud auth configure-docker europe-docker.pkg.dev

# Then proceed with tagging and pushing
docker tag "$1" "${DOCKER_IMAGE_PRODUCTION}:${VERSION}"
docker push "${DOCKER_IMAGE_PRODUCTION}:${VERSION}"
docker tag "$1" "${DOCKER_IMAGE_PRODUCTION}:latest"
docker push "${DOCKER_IMAGE_PRODUCTION}:latest"