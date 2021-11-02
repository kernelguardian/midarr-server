FROM elixir:latest

RUN apt-get update && \
    apt-get install -y inotify-tools postgresql-client libavcodec-dev libavformat-dev libavutil-dev

RUN mkdir /app

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

EXPOSE 4000