FROM ruby:2.7
MAINTAINER alvaroescobaronline@gmail.com
# Install apt based dependencies required to run Rails as
# well as RubyGems. As the Ruby image itself is based on a
# Debian image, we use apt-get to install those.
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs
# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN mkdir -p /app
WORKDIR /app
# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5
# Copy the main application.
COPY . ./
# Overwrite the .env with the .env.docker one
RUN rm ./.env
RUN mv ./.env.docker ./.env
# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000
# Configure an entry point, so we don't need to specify
# "bundle exec" for each of our commands.
ENTRYPOINT ["bundle", "exec"]
# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["rails", "server", "-b", "0.0.0.0"]
# These are important docker commands
# Delete all images
# docker rmi $(docker images -a -q)
#
# Delete all exited containers
# docker rm $(docker ps -a -f status=exited -q)
#
# Remove containers according to a pattern
# docker ps -a | grep "pattern" | awk '{print $1}' | xargs docker rm
#
# Kill stuck containers
# ps aux | grep <<container id>> | awk '{print $1 $2}'
# <<user>><<process id>>
# sudo kill -9 <<process id from above command>>
