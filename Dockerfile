FROM debian:wheezy

MAINTAINER Minku Lee <minku@sha.kr>

# Enable backports
RUN echo "deb http://http.debian.net/debian wheezy-backports main" >> /etc/apt/sources.list

# Install dependencies packages
RUN apt-get update && apt-get install -y \
  autoconf bison build-essential locales libssl-dev libyaml-dev \
  libreadline6-dev  zlib1g-dev libncurses5-dev libpq-dev \
  subversion imagemagick curl git && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8
    
ENV LC_ALL C.UTF-8

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