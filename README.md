# Gnukhata Build Config

This repository contains config files for building gnukhata, for docker and windows.

## Docker

The recommended way of trying gnukhata is via docker compose. First, We need to install the dependencies.

Requirements:

- Docker
- Docker compose

- for ubuntu/debian based distributions:

`sudo apt install docker.io docker-compose`

- You can also install docker compose via pip:

`pip install docker-compose`

- Clone the repo & use below commands

```sh
git clone https://gitlab.com/gnukhata/build.git

cd build

sudo docker-compose up -d

```

Now you can access gkapp at `localhost:2020` & gkcore at `localhost:6543` from your browser 🎉

To stop the container, run `sudo docker-compose down` in the same directory

**NOTE:** gnukhata's data is stored to `gkdir` folder in user's home directory

## Windows

There are several options to create an installer file for windows. Here we have used the software
called Innosetup for that purpose.

Use the following steps to create a GNUKhata installer for windows,

1. Clone the [build](https://gitlab.com/gnukhata/build) repo to your windows system.
2. Clone the [gkcore](https://gitlab.com/gnukhata/gkcore) and [gkwebapp](https://gitlab.com/gnukhata/gkwebapp) repos to your system and checkout to the desired branches with the latest code.
3. Download all the dependencies listed in Dependency.md file.
4. Download and install Innosetup.
5. Open Innosetup and load the file [GNUKhata_Installer.iss](https://gitlab.com/gnukhata/build/-/blob/master/Windows/GNUKhata_Installer.iss).
6. Update the dependency paths in GNUKhata_installer.iss file to suit your folder structure.
7. Comment out and uncomment the lines in GNUKhata_installer.iss file based on the CPU architecture you are building for.
8. Press on the compile button at the top of Innosetup software to create the installer file.
