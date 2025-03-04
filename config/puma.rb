# config/puma.rb

port ENV.fetch("PORT", 80)    # Use the PORT env var if available, otherwise fallback to 4567
bind "tcp://0.0.0.0:#{ENV.fetch('PORT', 80)}"  # Ensure it binds to 0.0.0.0
