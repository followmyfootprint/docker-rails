rails-docker
============

**rails-docker** is a minimal docker image suitable for Ruby on Rails application deployment. While the size of [offical Rails image] is ~950MB, this image uses ~560MB. 


## Example Dockerfile

    FROM shakr/rails:0.2.2

    ADD . /opt/backend
    WORKDIR /opt/backend

    RUN bundle install

    EXPOSE 80
    CMD ["bundle", "exec", "rails", "s", "-p", "80"]
