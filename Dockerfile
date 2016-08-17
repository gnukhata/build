FROM ubuntu@sha256:c6674c44c6439673bf56536c1a15916639c47ea04c3d6296c5df938add67b54b


MAINTAINER Navin<navin@dff.org.in> | Ishan <imasdekar@dff.org.in> | Krishnakant Mane <kk@dff.org.in>
#make necessary changes to file system and copy files.
RUN mkdir gnukhata
#creating necessary users and giving the permissions.
RUN groupadd -g 110 postgres && useradd -u 105 gkadmin && useradd -u 106 -g 110 postgres


# installing required dependencies 
RUN apt-get update && apt-get install -y \
    python2.7 \
    postgresql-9.5 \
    python-pip \
    python-dev \
    libpq-dev \
    git \
    nginx \
    && apt-get autoclean -y &&\
    apt-get autoremove -y &&\
    pip install pyramid \
    psycopg2 \
    odslib\
    sqlalchemy \
    waitress \
    supervisor \
    wsgicors \
    requests \
    monthdelta \
    pyjwt \
    pillow

#first copy important scripts into /gnukhata
#then give read and execute permisions
COPY gkutil.sh startscript.sh supervisord.conf /gnukhata/
RUN chmod 755 /gnukhata/gkutil.sh && chmod 755 /gnukhata/startscript.sh && chmod 755 /gnukhata/supervisord.conf && \
    chown  gkadmin /gnukhata


#copy the configuration files for nginx since it is now installed.


#initialise postgresql and create the empty database for GNUKhata.

#final setup
#clone the git repository and then create tables in the database.s


WORKDIR /gnukhata
RUN git clone https://gitlab.com/gnukhata/gkcore.git \
    && git clone https://gitlab.com/gnukhata/gkwebapp.git

COPY nginx.conf /etc/nginx/
COPY gnukhata.conf /etc/nginx/conf.d/


WORKDIR /gnukhata/gkcore
RUN python setup.py develop
RUN service postgresql start && su -c "createuser gkadmin" postgres && su -c "/gnukhata/gkutil.sh" postgres && \
    su -c "python /gnukhata/gkcore/initdb.py" gkadmin
WORKDIR /gnukhata/gkwebapp
RUN python setup.py develop 



WORKDIR /gnukhata
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
RUN apt-get autoremove -y git && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#USER root
EXPOSE 80
ENTRYPOINT /gnukhata/startscript.sh
