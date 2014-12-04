pidfile "/tmp/RubyMe.pid"
state_path "/tmp/RubyMe.state"
daemonize true
workers 0
threads 0, 16
bind 'tcp://0.0.0.0:8090'
environment 'production'
on_restart do
  puts 'RubyMe on restart...'
end

preload_app!
