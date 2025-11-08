FROM lua:5.4-alpine

WORKDIR /app

RUN apk add --no-cache lua-socket lua-json

COPY . .

EXPOSE 8086

CMD ["lua", "main.lua"]

