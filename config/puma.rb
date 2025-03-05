# config/puma.rb

workers Integer(ENV.fetch("WEB_CONCURRENCY", 2))  # Adjusts for better performance
threads_count = Integer(ENV.fetch("RAILS_MAX_THREADS", 5))
threads threads_count, threads_count

preload_app!

port ENV.fetch("PORT") { 3000 }  # Ensure it binds to a dynamic port
bind "tcp://0.0.0.0:#{ENV.fetch('PORT', 3000)}"

environment ENV.fetch("RACK_ENV") { "development" }

# Graceful shutdown
on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end
