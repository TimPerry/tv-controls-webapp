FROM node:6.9

WORKDIR /usr/src/app

ENV HOME=/tmp

RUN apt install -y gcc
RUN echo "int chown() { return 0; }" > preload.c && gcc -shared -o /libpreload.so preload.c && rm preload.c
ENV LD_PRELOAD=/libpreload.so

RUN apt-key adv --keyserver pgp.mit.edu --recv D101F7899D41F3C3
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install yarn

COPY package.json yarn.lock /usr/src/app/
RUN yarn install

COPY elm-package.json /usr/src/app
RUN ./node_modules/.bin/elm-github-install

COPY . /usr/src/app

RUN yarn run build

CMD ["yarn", "start"]

EXPOSE 8080
