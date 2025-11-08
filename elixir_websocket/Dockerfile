FROM elixir:1.15-alpine

WORKDIR /app

COPY mix.exs mix.lock ./
RUN mix deps.get

COPY . .

RUN mix compile

EXPOSE 8085

CMD ["mix", "run", "--no-halt"]

