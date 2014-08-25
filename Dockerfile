FROM ubuntu:14.04

MAINTAINER Minku Lee <minku@sha.kr>

# Install dependencies packages
RUN apt-get update && apt-get install -y \
  build-essential \
  openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev \ 
  libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev \
  autoconf libc6-dev ncurses-dev automake libtool bison nodejs subversion \
  libpq-dev imagemagick

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Build & install ruby
RUN mkdir /tmp/ruby && curl http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz | tar xzf - --strip=1 -C /tmp/ruby && \
  	cd /tmp/ruby && \
  	autoconf && \
  	./configure && \
  	make -j$(nproc) && \
  	make install && \
  	rm -rf /tmp/ruby

# Disable document generation when installing gems
RUN echo "gem: --no-document" >> ~/.gemrc

# Install rails and bundler
RUN gem install rails bundler
