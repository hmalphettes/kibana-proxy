kibana-proxy
============

Hosts [Kibana 3](http://three.kibana.org) as a nodejs express application.

Features:
- Proxy access to Elasticsearch: all elasticsearch queries are sent through the express application.
- Optional Google OAuth2 login with (passport)[http://passport.org].
- Support for Elasticsearch protected by basic-authentication: only the express app will know about the username and password.

Front-ends specifically tested:
- [Kibana 3](http://three.kibana.org)
- [Head](https://github.com/mobz/elasticsearch-head)
- [Bigdesk](https://github.com/lukas-vlcek/bigdesk)

Note regarding Kibana 4: it won't be supported here.
----------------------------------------------------
Kibana 4 requires its own web-tier; it processes the requests issued by the browser and then sends them to Elasticsearch.

Reference: https://github.com/elasticsearch/kibana/issues/1628#issuecomment-58611294

For Kibana 4 it seems an authentication plugin is what is needed to replace this proxy.

Usage
=====

```
git clone https://github.com/hmalphettes/kibana-proxy.git
npm install
npm start &
open http://localhost:3003/index.html
open http://localhost:3003/_plugin/head
open http://localhost:3003/_plugin/bigdesk
```

Configuration
=============
Configuration is done via environment variables:
- `ES_URL`: example: `http://user:password@your-elasticsearch.local`; default: `http://localhost:9200`
- `PORT`: the port where the app is run, default to `VCAP_PORT` and then to `3003`.
- `APP_ID`, `APP_SECRET`: Google OAuth2 config. Optional.
- `AUTHORIZED_EMAILS`: define what authenticated email is granted access; a comma separated listed of patterns; defaults to `*`. example: `*@stoic.com,justme@gmail.com` each pattern must be one-of:
    - `*`: anything,
    - `*@domain`: any email in the domain
    - `an@email`: a specific email.
- OTHER_REVERSE_PROXIED: optional: Proxy to other host. For example to proxy to the consul UI: '{"/v1,/ui":{"host":"localhost","port":8500}}'

Docker Usage
============
```
docker run -e APP_ID=abc APP_SECRET=def hmalphettes/kibana-proxy
```

Push to cloudfoundry.com
========================
- Copy the `manifest-example.yml` file as `manifest-real.yml` provided as an example.
- Must: change the name of the app and elasticsearch URL.
- Could: add `APP_ID`, `APP_SECRET` and `AUTHORIZED_EMAILS` to protect access.
- `vmc push --manifest-real.yml`.

Resources
=========
- [Kibana 3](http://three.kibana.org) and its friend [Logstash](http://logstash.net)
- Generate some logs from nodejs without going through logstash: [log4js-elasticsearch](https://github.com/hmalphettes/log4js-elasticsearch)

License
=======
kibana-proxy is freely distributable under the terms of the MIT license.

Copyright (c) 2013 Sutoiku, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
