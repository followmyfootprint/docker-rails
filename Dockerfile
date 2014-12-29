FROM debian:wheezy

MAINTAINER Minku Lee <minku@sha.kr>

# Enable backports
RUN echo "deb http://http.debian.net/debian wheezy-backports main" >> /etc/apt/sources.list

# Install dependencies packages
RUN apt-get update && apt-get install -y \
  build-essential \
  openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev \ 
  libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev \
  autoconf libc6-dev ncurses-dev automake libtool bison nodejs subversion \
  libpq-dev imagemagick && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Build & install ruby
RUN mkdir /tmp/ruby && curl http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz | tar xzf - --strip=1 -C /tmp/ruby && \
  	cd /tmp/ruby && \
  	autoconf && \
  	./configure && \
  	make -j$(nproc) && \
  	make install && \
  	rm -rf /tmp/ruby

# Disable document generation, update RubyGems and install Rails/Bundler 
RUN echo "gem: --no-document" >> ~/.gemrc && gem update --system && gem install rails bundler