# Cellranger-5

**Build the docker by using Docker file**
```docker build -f Dockerfile -t Cellranger5
```

**Build docker directly from github**
```docker build https://github.com/KumarUCD/Cellranger-5.git -f Dockerfile -t cellranger-5
```

**Check docker images**
```docker images
```

**Start application in jupyter lab**
```docker run --rm -p 8888:8888 -e -v "$PWD":/home/workspace cellranger-5:latest
```

**Start application in terminal**
```docker run --name ubuntu_bash --rm -i -t cellranger-5:latest bash
```



