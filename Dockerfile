FROM node:18-alpine3.15 as builder

WORKDIR '/app'

COPY package.json .
RUN npm i
RUN mkdir -p node_modules/.cache && chmod -R 777 node_modules/.cache
COPY . .

RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
