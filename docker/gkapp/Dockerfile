FROM node:gallium-alpine as build

# this variable decides which gkcore backend to use
# ENV VUE_APP_GKCORE_URL=http://:6543
ARG archive_name=gkapp.tar.gz

# add git 
# RUN apt update && apt install git -y
RUN apk update && apk add git

# clone gkapp
RUN git clone https://gitlab.com/gnukhata/gkapp.git && cd gkapp

# build gkapp & compress the output files to an archive
WORKDIR /gkapp
RUN npm install -g @vue/cli &&\ 
		npm install &&\
		npm run build &&\
		cd dist &&\
		tar -cf ${archive_name} *

# get nginx image & copy gkapp artifacts to it
FROM nginx:stable-alpine

COPY --from=build /gkapp/dist/gkapp.tar.gz /usr/share/nginx/html/

WORKDIR /usr/share/nginx/html
RUN tar -xf gkapp.tar.gz && ls -al

EXPOSE 80
