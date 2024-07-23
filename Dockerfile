FROM public.ecr.aws/r3m4q3r9/pub-mirror-node:13-alpine

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY . .

RUN npm install

EXPOSE 3000

CMD node ./bin/www
