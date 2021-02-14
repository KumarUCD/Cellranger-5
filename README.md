# Cellranger-5
### Build the docker by using Docker file
```
docker build -f Dockerfile -t Cellranger5
```
### Build docker directly from github
````
docker build git@github.com:Kumar-4U/Cellranger-5.git#master:basic.notebook.u18 -f Dockerfile -t cellranger-5
````
#### Check docker images
```
docker images
```
### Start application in jupyter lab
```
docker run --rm -p 8888:8888 -e -v "$PWD":/home/workspace cellranger-5:latest
```


### Start application in terminal
```
docker run --name ubuntu_bash --rm -i -t cellranger-5:latest bash
```

``

### Load the image into Docker:
```
## docker load -i <path to image tar file>
docker load -i ~/OneDrive/My-Final-docker-for-RNA-seq/cellranger_u19.tar
```
### Purging All Unused or Dangling Images, Containers, Volumes, and Networks
````docker system prune && docker system prune -a ````
### Remove one or more specific images
**List:** 
````
docker images -a
````

**Remove:**
````
docker rmi Image Image
````
#======================
#### how to update github
#=======================
````
git add * && git commit -m "update" && git push origin master

````
