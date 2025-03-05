# config/puma.rb

port ENV.fetch("PORT", 3000)  # Ensure Puma binds to the correct port
bind "tcp://0.0.0.0:#{ENV.fetch('PORT', 3000)}"

workers Integer(ENV.fetch("WEB_CONCURRENCY", 2))
threads_count = Integer(ENV.fetch("RAILS_MAX_THREADS", 5))
threads threads_count, threads_count

preload_app!

environment ENV.fetch("RACK_ENV", "development")

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end
