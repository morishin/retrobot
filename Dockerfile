FROM ruby:2.2

COPY . /app
WORKDIR /app
RUN bundle install
CMD bundle exec bin/retrobot -c /app/retrobot.docker.yml
