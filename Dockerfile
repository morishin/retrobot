FROM ruby:2.2

ENV LC_ALL C.UTF-8

COPY . /app
WORKDIR /app
RUN bundle install
CMD bundle exec bin/retrobot -c /app/retrobot.docker.yml
