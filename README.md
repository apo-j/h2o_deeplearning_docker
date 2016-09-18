# H2o Tensorflow Spark
---
  To test this demo, we provide the installation guid to run the following demo:
  https://www.youtube.com/watch?v=62TFK641gG8&feature=youtu.be
## H2o by docker
To build your deockerfile:

```bash
mkdir folder_of_yourdocker
cd folder_of_yourdocker
touch Dockerfile
open -e Dockerfile
docker build -t name-of-container .
```

To run your docker container:
```bash
docker run -it --name name-of-image -p 8000:8000 -p 8888:8888 -p 54321:54321 -p 54322:54322 -p 6006:6006 -v /flodertoyournotebook/notebook:/notebook --rm name-of-container /bin/bash
```
You can then add notebook file in a folder called notebook, which allows the share file between your PC and your container. We note that even you delate the docker all the datas and files in the notebook floder are always available.

Now you sparkling with tensorflow can be lanuch by the following commande:
```bash
IPYTHON_OPTS=notebook $SPARKLING_WATER_HOME/bin/pysparkling
```

## H2o standalone
You can also install H2o in all the OS system. The details installation guid is detailed in the doc.



