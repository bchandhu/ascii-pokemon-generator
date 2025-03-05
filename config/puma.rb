# config/puma.rb

require 'socket'

# Function to find an available port if 3000 is in use
def find_available_port(start_port = 3000, end_port = 3100)
  (start_port..end_port).each do |port|
    begin
      server = TCPServer.new('0.0.0.0', port)
      server.close
      return port
    rescue Errno::EADDRINUSE
      next
    end
  end
  raise "No available ports found in range #{start_port}-#{end_port}"
end

PORT = ENV.fetch("PORT") { find_available_port }

port PORT
bind "tcp://0.0.0.0:#{PORT}"

workers Integer(ENV.fetch("WEB_CONCURRENCY", 2))
threads_count = Integer(ENV.fetch("RAILS_MAX_THREADS", 5))
threads threads_count, threads_count

preload_app!

environment ENV.fetch("RACK_ENV", "development")

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end
