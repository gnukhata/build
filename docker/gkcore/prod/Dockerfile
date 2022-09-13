FROM python:slim

MAINTAINER Sai Karthik <kskarthik@disroot.org>

# GNUKhata Branch
ARG branch=devel

# Postgres instance url for gkcore
ENV GKCORE_DB_URL=postgres://gkadmin:gkadmin@db:5432/gkdata

# installing required dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -y build-essential wget libpq-dev

#first copy important scripts into /gnukhata
#then give read and execute permisions

RUN mkdir /gnukhata

WORKDIR /gnukhata

COPY startscript.sh /gnukhata/
RUN chmod 755 startscript.sh

# Download the respositories from their master branch
RUN wget https://gitlab.com/gnukhata/gkcore/-/archive/${branch}/gkcore-${branch}.tar.gz &&\
	tar -xf gkcore-${branch}.tar.gz &&\
	mv gkcore-${branch} gkcore && ls -al gkcore

WORKDIR /gnukhata/gkcore

# install gkcore dependencies
RUN pip install -r requirements.txt && python3 setup.py develop

# clean build environment
RUN apt purge build-essential wget -y &&\
	apt-get autoremove -y &&\
	apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

WORKDIR /gnukhata

# expose gkcore port
EXPOSE 6543

ENTRYPOINT /gnukhata/startscript.sh
