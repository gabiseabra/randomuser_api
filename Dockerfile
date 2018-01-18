
FROM ruby:2.4

WORKDIR /usr/src/app

RUN apt-get update && \
    apt-get install build-essential libxml2-dev libxslt-dev -y && \
    gem install nokogiri -v 1.8.1 -- --use-system-libraries

COPY Gemfile Gemfile.lock ./

RUN bundle install --retry 5 --without development test

ENV RAILS_ENV production 
ENV RACK_ENV production
ENV RAILS_ROOT /usr/src/app
ENV RAILS_SERVE_STATIC_FILES 1
# You must pass environment variable SECRET_KEY_BASE
ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE $SECRET_KEY_BASE

# Copy the main application.
COPY . ./

EXPOSE 8080

# Start server
CMD bundle exec puma -b 'tcp://0.0.0.0:8080'
