# Dockerfile for local Travis build test

FROM ubuntu
LABEL maintainer="Ian Blenke <ian@blenke.com>"

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y cmake curl git ruby bundler wget unzip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && gem install bundler travis --no-ri --no-rdoc \
  && git clone --depth 1 https://github.com/travis-ci/travis-build ~/.travis/travis-build \
  && bundle install --gemfile ~/.travis/travis-build/Gemfile

ADD . /tesseract
WORKDIR /tesseract

RUN travis compile | sed -e "s/--branch\\\=\\\'\\\'/--branch=master/g" | bash
