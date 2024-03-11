# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.2
FROM registry.docker.com/library/ruby:$RUBY_VERSION as base

# Rails app lives here
WORKDIR /app

# Set production environment
ENV RAILS_ENV="development" \
    BUNDLER_VERSION=2.5.6


# Throw-away build stage to reduce size of final image
FROM base as build

# Install packages needed to build gems
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libvips pkg-config

RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \  linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      nodejs \
      openssl \
      pkgconfig \
      postgresql-dev \
      python \
      tzdata \
      yarn

# Install application gems
RUN gem install bundler
COPY Gemfile Gemfile.lock ./


# set the configuration options for the nokogiri gem build
RUN bundle config build.nokogiri --use-system-libraries

# install gemfile dependencies
#RUN bundle check || bundle install

COPY package.json yarn.lock ./

RUN yarn install --check-files \

#Copy application code
COPY . ./

# Adjust binfiles to be executable on Linux
RUN chmod +x bin/* && \
    sed -i "s/\r$//g" bin/* && \
    sed -i 's/ruby\.exe$/ruby/' bin/*

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1


# Final stage for app image
FROM base

# Install packages needed for deployment

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000

#CMD ["rails", "server", "-b", "0.0.0.0"]
