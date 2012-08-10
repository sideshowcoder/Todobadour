mail: bundle exec mailcatcher
web: bundle exec thin start -e development -p 3000
websocket: bundle exec rackup faye.ru -s thin -E production -p 9292
worker: bundle exec rake resque:work QUEUE="*"