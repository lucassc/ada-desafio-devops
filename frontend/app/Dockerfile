FROM node:14 as build
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY ./ /app/
RUN npm install -g @angular/cli
RUN npm install -g webpack
RUN npm link webpack

RUN npm run build --prod --configuration=prod


FROM nginx:1.23.3-alpine 

RUN touch /run/nginx.pid && chown -R 1000:1000 /run/nginx.pid

run chown -R 1000:1000 /var/cache/nginx

USER 1000

COPY --from=build /app/dist/letscodebyada-app /usr/share/nginx/html
COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf

EXPOSE 5000
CMD ["/bin/sh", "-c", "envsubst < /usr/share/nginx/html/assets/env.template.js > /usr/share/nginx/html/assets/env.js && exec nginx -g 'daemon off;'"]