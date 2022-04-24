FROM teddysun/xray
RUN apk add --no-cache acme.sh socat gettext nginx \
 && sed -i 's/user nginx/#&/' /etc/nginx/nginx.conf \
 && echo "Hello World" > /var/www/index.html \
 && curl -sSL https://github.com/cloudflare/wrangler/releases/download/v1.19.12/wrangler-v1.19.12-x86_64-unknown-linux-musl.tar.gz | tar zxf - \
 && mv dist/wrangler /usr/bin/ \
 && rm -rf dist/
ADD default.conf /etc/nginx/default.conf
ADD config_client /xray/client/
ADD config.json /xray/config.json
ADD entrypoint.sh /
CMD /entrypoint.sh
