port ENV.fetch("PORT", "3000")
bind "tcp://0.0.0.0:#{ENV.fetch('PORT', '3000')}"
