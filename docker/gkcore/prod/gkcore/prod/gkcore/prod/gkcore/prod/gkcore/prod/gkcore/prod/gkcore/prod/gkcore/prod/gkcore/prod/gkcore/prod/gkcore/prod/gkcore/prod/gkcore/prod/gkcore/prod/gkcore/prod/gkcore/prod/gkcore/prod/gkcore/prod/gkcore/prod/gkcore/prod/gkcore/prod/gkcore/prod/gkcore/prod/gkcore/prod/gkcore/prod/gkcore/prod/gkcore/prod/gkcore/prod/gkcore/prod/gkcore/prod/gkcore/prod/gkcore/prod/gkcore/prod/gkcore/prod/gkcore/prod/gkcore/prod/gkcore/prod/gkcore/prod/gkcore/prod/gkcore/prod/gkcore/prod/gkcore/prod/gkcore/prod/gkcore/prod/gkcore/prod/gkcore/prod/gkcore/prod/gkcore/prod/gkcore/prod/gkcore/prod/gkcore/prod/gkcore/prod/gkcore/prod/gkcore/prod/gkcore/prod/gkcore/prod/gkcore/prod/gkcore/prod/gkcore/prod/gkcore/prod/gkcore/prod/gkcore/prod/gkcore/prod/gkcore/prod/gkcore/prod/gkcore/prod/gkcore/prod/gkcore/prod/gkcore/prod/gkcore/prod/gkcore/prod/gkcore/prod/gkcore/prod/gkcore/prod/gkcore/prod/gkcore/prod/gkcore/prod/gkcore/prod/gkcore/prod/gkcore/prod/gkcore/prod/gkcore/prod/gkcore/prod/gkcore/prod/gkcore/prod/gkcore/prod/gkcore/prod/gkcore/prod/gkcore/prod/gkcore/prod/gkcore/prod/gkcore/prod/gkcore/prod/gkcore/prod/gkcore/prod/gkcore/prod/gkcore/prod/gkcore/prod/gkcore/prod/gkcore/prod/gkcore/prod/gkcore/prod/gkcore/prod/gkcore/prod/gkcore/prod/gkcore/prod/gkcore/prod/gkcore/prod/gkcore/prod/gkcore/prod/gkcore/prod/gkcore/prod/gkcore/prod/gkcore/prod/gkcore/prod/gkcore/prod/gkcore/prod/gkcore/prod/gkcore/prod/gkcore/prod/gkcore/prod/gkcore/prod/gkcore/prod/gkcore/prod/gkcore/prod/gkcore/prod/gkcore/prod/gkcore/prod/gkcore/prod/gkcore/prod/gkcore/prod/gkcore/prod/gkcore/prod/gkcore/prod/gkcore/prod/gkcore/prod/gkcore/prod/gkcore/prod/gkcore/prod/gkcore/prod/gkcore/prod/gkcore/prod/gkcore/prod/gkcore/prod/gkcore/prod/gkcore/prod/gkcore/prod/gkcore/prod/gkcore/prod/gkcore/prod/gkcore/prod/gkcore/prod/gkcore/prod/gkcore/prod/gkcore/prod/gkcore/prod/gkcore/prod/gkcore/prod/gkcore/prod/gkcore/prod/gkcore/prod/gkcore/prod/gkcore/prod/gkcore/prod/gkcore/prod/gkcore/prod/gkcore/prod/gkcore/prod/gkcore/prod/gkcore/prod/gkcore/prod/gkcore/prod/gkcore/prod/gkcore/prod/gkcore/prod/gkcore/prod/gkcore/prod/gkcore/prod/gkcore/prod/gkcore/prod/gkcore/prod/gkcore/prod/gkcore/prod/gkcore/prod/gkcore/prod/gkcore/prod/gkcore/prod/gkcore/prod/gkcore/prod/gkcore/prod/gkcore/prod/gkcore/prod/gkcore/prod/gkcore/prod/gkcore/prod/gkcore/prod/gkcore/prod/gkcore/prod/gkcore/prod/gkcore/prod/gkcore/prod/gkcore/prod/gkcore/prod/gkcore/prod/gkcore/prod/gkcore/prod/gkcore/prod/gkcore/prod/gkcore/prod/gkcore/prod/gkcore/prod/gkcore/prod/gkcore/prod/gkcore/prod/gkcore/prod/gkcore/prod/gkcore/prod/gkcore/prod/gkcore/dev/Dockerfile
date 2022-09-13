FROM python:3.8-buster

MAINTAINER Sai Karthik <kskarthik@disroot.org>

# GNUKhata Branch
ARG branch=devel

# Postgres instance url for gkcore
ENV GKCORE_DB_URL=postgres://gkadmin:gkadmin@db:5432/gkdata

# installing required dependencies
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y build-essential git libpq-dev htop

#first copy important scripts into /gnukhata
#then give read and execute permisions

RUN mkdir /gnukhata
COPY startscript.sh supervisord.conf /gnukhata/

WORKDIR /gnukhata
RUN chmod 755 startscript.sh supervisord.conf


# Download the respositories from their master branch
RUN git clone -b $branch --depth 1 https://gitlab.com/gnukhata/gkcore.git
# RUN git clone -b $branch --depth 1 https://gitlab.com/gnukhata/gkwebapp.git

WORKDIR /gnukhata/gkcore

# install gkcore dependencies
RUN pip3 install -r requirements.txt && python3 setup.py develop

# WORKDIR /gnukhata/gkwebapp
#
# # install gkwebapp dependencies
# RUN pip3 install -r requirements.txt && python3 setup.py develop

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /gnukhata
# expose gkwebapp, gkcore ports
EXPOSE 6543
# EXPOSE 6544

ENTRYPOINT /gnukhata/startscript.sh
