environment 'production'
daemonize
workers 1
pidfile '/home/storyhooter/tmp/pids/puma.pid'
state_path '/home/storyhooter/tmp/puma.state'
bind 'unix:///home/storyhooter/tmp/puma.sock'
