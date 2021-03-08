workers Integer(ENV['WEB_CONCURRENCY'] || 1)
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup

environment ENV['RACK_ENV'] || 'development'

if ENV['DISABLE_SSL'] == 'false'
  ssl_bind '0.0.0.0', '3000', {
    key: ENV['SSL_KEY_PATH'],
    cert: ENV['SSL_CERT_PATH'],
    verify_mode: 'none'
  }
else
  port        ENV['PORT'] || 3000
end

on_worker_boot do
  ActiveRecord::Base.establish_connection
end

before_fork do
  # configuration here
end
