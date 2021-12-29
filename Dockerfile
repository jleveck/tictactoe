FROM ruby:2.6.1-slim
ARG VERSION=4.0.0

RUN apt-get update -qq
RUN apt-get install -y build-essential default-libmysqlclient-dev default-mysql-client imagemagick libmagickwand-dev curl git sudo apt-transport-https unzip cmake vim jq wget

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
       && apt-get install -y nodejs

RUN useradd -u 1000 --create-home -d /app --shell /bin/bash cryo \
      && adduser cryo sudo

RUN apt-get install -y openssh-client

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN wget https://github.com/cdr/code-server/releases/download/v${VERSION}/code-server-${VERSION}-linux-amd64.tar.gz -O code-server.tar.gz \
    && tar -xvf code-server.tar.gz \
    && rm code-server.tar.gz \
    && mv code-server-${VERSION}-linux-amd64 code-server

RUN mkdir -p code-server/data/user-data-dir \
    && mkdir -p code-server/data/extensions-dir
