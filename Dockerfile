FROM ubuntu:14.04

RUN apt-get -y update
RUN apt-get -y install ruby2.0
RUN gem2.0 install bundler

COPY . /app
WORKDIR /app
RUN bundle install --path=vendor/bundle
CMD bundle exec bin/retrobot -c /app/retrobot.docker.yml
