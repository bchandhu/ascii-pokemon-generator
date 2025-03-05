# Set the number of worker processes (for clustered mode)
workers Integer(ENV.fetch("WEB_CONCURRENCY", 2))  # Adjust workers for performance

# Set the number of threads per worker
threads_count = Integer(ENV.fetch("RAILS_MAX_THREADS", 5))
threads threads_count, threads_count

# Preload the application before forking workers (recommended for performance)
preload_app!

# Use environment variables to set the port (Render provides it dynamically)
port ENV.fetch("PORT", 3000)

# Ensure the server binds to 0.0.0.0 (needed for Render & Docker)
bind "tcp://0.0.0.0:#{ENV.fetch('PORT', 3000)}"

# Set the execution environment
environment ENV.fetch("RACK_ENV", "development")

# Ensure database connections are re-established for each worker
on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

# Allow Puma to be restarted by `rails restart` command
plugin :tmp_restart
