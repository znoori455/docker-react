FROM node:alpine as builder
# builder block is everything down to the next FROM stanza
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build has all the stuff we need
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# this is saying I want to copy something
# from the other phase I was working on
# the default command of the nginx image will
# start up nginx for us ; 6:84 for more info