FROM ubuntu:15.10
MAINTAINER Jiqiong QIU <jiqiong.qiu@gmail.com>
# Upgrade package index
RUN apt-get update

# Repo
#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
# Java 7 installation from Oracle
RUN apt-get install --no-install-recommends software-properties-common -y && apt-add-repository ppa:webupd8team/java

RUN apt-get update
RUN apt-get install -y zip
RUN apt-get install -y wget
RUN apt-get install -y openjdk-7-jdk

# automatically accept oracle license
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

# and install java 7 oracle jdk
RUN apt-get -y install oracle-java7-installer --no-install-recommends && apt-get clean
RUN apt-get -y install oracle-java7-set-default --no-install-recommends

RUN apt-get install python-pip python-dev -y
RUN apt-get install build-essential
# Install additional tools
RUN apt-get -y install --no-install-recommends \
  less \
  curl \
  vim-tiny \
  sudo \
  openssh-server \
  unzip\
  python-pip\
  python-dev

# Install Spark 1.6.2
RUN curl -s https://archive.apache.org/dist/spark/spark-1.6.1/spark-1.6.1-bin-cdh4.tgz | tar -xz -C /opt && \
    ln -s /opt/spark-1.6.1-bin-cdh4 /opt/spark && \
    mkdir /opt/spark/work && \
    chmod 0777 /opt/spark/work

# Install Sparkling water latest version
RUN curl -s http://h2o-release.s3.amazonaws.com/sparkling-water/rel-1.6/5/sparkling-water-1.6.5.zip --output sw.zip && \
  unzip sw.zip -d /opt/ && \
  ln -s /opt/sparkling-water-1.6.5 /opt/sparkling-water && \
  rm -f sw.zip

RUN apt-get install libblas-dev liblapack-dev libatlas-base-dev gfortran -y
RUN pip install\
 numpy\
 scipy\
 requests\
 tabulate\
 future\
 six\
 pandas\
 scikit-learn \
 jupyter 

RUN pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.9.0-cp27-none-linux_x86_64.whl
RUN pip install http://h2o-release.s3.amazonaws.com/h2o/rel-turchin/9/Python/h2o-3.8.2.9-py2.py3-none-any.whl

# Setup environment
ENV SPARK_HOME /opt/spark
ENV SPARKLING_WATER_HOME /opt/sparkling-water

#ENV SPARK_MASTER_PORT 7077
#ENV SPARK_MASTER_WEBUI_PORT 8080
#ENV SPARK_WORKER_PORT 8888
#ENV SPARK_WORKER_WEBUI_PORT 8081
# Add a notebook profile.
RUN mkdir -p -m 700 /root/.jupyter/ && \
    echo "c.NotebookApp.ip = '*'" >> /root/.jupyter/jupyter_notebook_config.py
RUN mkdir /notebook
VOLUME /notebook

EXPOSE 8888 
EXPOSE 54321
EXPOSE 54322
EXPOSE 8000
EXPOSE 6006

RUN apt-get build-dep python-matplotlib -y
RUN pip install https://github.com/hpec/test_helper/tarball/0.1
RUN pip install matplotlib
#CMD ["jupyter", "notebook", "--no-browser", "--allow-root"]
#CMD [“IPYTHON_OPTS” ,”=“,“notebook“, “$SPARKLING_WATER_HOME/bin/pysparkling”]
#CMD jupyter notebook 
