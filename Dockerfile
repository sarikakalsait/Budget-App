FROM ruby:3.1.2

# set the working directory in the container
WORKDIR /app

# copy the Gemfile and Gemfile.lock file in the container
COPY Gemfile Gemfile.lock ./

# install Bundler and dependencies
RUN gem install bundler:2.3.6
RUN bundle install
RUN bundle exec rails db:create
RUN bundle exec rails db:migrate

# Copy the rest of the application code into the container
COPY . .

# Install Node-Js dependencies
RUN apt-get update && apt-get install -y nodejs

# Expose the port on which the application will run
EXPOSE 3000

# Start the Rails Application
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
