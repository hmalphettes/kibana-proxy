FROM google/nodejs
MAINTAINER Hugues MALPHETTES <hmalphettes@gmail.com>

WORKDIR /app
# ADD package.json /app/
# RUN npm install
ADD . /app
RUN \
  npm install &&\
  mkdir -p /app/kibana-build &&\
  curl https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz | tar xvzf - -C /app/kibana-build --strip-components=1

CMD []
ENTRYPOINT ["/nodejs/bin/npm", "start"]