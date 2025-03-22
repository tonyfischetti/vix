# docker, delete, delete all images, delete all containers

#  you should remove all the containers before removing
#  all the images from which those containers were created

# containers
docker rm -vf $(docker ps -aq)

# images
docker rmi -f $(docker images -aq)

