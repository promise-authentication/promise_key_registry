# Use Ruby 2.7.6 as base image (more stable version)
FROM ruby:3.2.8-slim

# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libsqlite3-dev \
    git \
    postgresql \
    postgresql-client \
    libpq-dev \
    libsodium-dev \
    pkg-config \
    libyaml-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy Gemfile
COPY Gemfile Gemfile.lock ./

# Install compatible RubyGems and bundler versions
RUN gem install bundler

# Install dependencies
RUN bundle install
RUN bundle exec rails db:prepare

# Copy the rest of the application
COPY . .

# Set environment to development
ENV RAILS_ENV=development

# Expose port 3000
EXPOSE 3000

# Start the server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
