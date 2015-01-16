FROM google/nodejs
MAINTAINER Hugues MALPHETTES <hmalphettes@gmail.com>

WORKDIR /app
ADD . /app
RUN npm install

EXPOSE 3003

CMD ["/nodejs/bin/npm", "start"]
