#!/bin/bash
set -o errexit  # Exit on error

# Ensure dependencies are installed
bundle install

# Run database migrations (if using ActiveRecord)
bundle exec rake db:migrate || true
