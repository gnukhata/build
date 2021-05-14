# Gnukhata Build Config

This repository contains config files for building gnukhata on windows installer & docker images

## Docker

The recommended way of trying gnukhata is via docker compose. First, We need to install the dependencies. 

Requirements:

* Docker
* Docker compose

* for ubuntu/debian based distributions:

`sudo apt install docker.io docker-compose`

* You can also install docker compose via pip:

`pip install docker-compose`

* Clone the repo & use below commands

```sh
git clone https://gitlab.com/gnukhata/build.git

cd build

docker-compose up -d

```

Now you can access gkwebapp at `localhost:6544` & gkcore at `localhost:6543` from your browser 🎉

To stop the container, run `docker-compose down`

**NOTE:** gnukhata's data is stored to `gkdir` folder in user's home directory

## Windows [TODO]
