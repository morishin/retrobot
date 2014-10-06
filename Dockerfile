FROM ubuntu:14.04

RUN cat /etc/apt/sources.list | sed -e 's|http://[^ ]*|mirror://mirrors.ubuntu.com/mirrors.txt|g' > /tmp/sources.list && mv /tmp/sources.list /etc/apt/sources.list && apt-get -y update

RUN apt-get -y install ruby2.0
RUN gem2.0 install bundler

COPY . /app
WORKDIR /app
RUN bundle install --path=vendor/bundle
CMD bundle exec bin/retrobot -c /app/retrobot.docker.yml
