# Use an official Ruby image as a base
FROM ruby:3.2

# Install dependencies (ImageMagick and any other necessary packages)
RUN apt-get update && apt-get install -y \
    imagemagick \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the application code
COPY . .

# Install Ruby dependencies using Bundler
RUN bundle install

# Expose the port Puma will run on (Render uses dynamic ports, so we expose 80 by default)
EXPOSE 4567

# Start the application with Puma (this assumes you have a config/puma.rb file)
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
