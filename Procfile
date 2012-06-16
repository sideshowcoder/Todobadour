web: RAILS_ENV=production bundle exec thin start -p 3000 
worker: RAILS_ENV=production bundle exec rackup faye.ru -s thin -E production 