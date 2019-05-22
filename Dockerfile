FROM node:10

# Create app directory
#WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
# If you are building your code for production
# RUN npm ci --only=production
RUN mkdir -p /usr/app

COPY Metesic.tar.gz /usr/app/
#COPY bundle/. /usr/app

RUN cd /usr/app && tar -xvf Metesic.tar.gz
RUN cd /usr/app/bundle/programs/server && npm install

WORKDIR /usr/app/bundle

RUN mkdir -p /videos

#ADD /home/jeje/Videos /videos

#ENV METEOR_SETTINGS='$(cat settings.json)'
COPY settings.json /usr/app/bundle/

COPY package.json /usr/app/bundle/

#ENV SETTINGS_PATH=/usr/app/settings.json

ENV PORT=3000
ENV MONGO_URL=mongodb://172.17.0.2:27017/metesic
ENV ROOT_URL=http://localhost:3000/
CMD [ "npm", "start" ]
EXPOSE 3000

#EXPOSE 8080
#CMD [ "npm", "start" ]

