# Use an official Ruby image as a base
FROM ruby:3.2

# Install dependencies
RUN apt-get update && apt-get install -y \
    imagemagick \
    libmagickwand-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the application code
COPY . .

# Ensure bundler is installed and up to date
RUN gem install bundler

# Install Ruby dependencies using Bundler
RUN bundle install

# Expose the port Puma will run on
EXPOSE $PORT


# Start the application with Puma
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
