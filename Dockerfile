FROM ruby:2.6.6

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    yarn \
    default-mysql-client \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir /webapp
WORKDIR /webapp

ADD Gemfile /webapp/Gemfile
ADD Gemfile.lock /webapp/Gemfile.lock

RUN bundle install

ADD . /webapp

RUN mkdir -p tmp/sockets

EXPOSE 3000