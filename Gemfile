source 'https://rubygems.org'

gem 'rails', '3.2.12'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# for heroku deploy. Actually this definition is awful. It should be the same between development and production.
# gem 'sqlite3'
gem 'sqlite3', :group => [:development, :test]
group :production do
  gem 'thin'
  gem 'pg'
  gem 'mysql2'
  gem 'google-analytics-rails'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end


  # for this app.
  gem 'less-rails'
  gem 'less-rails-bootstrap'

  # for fuelux
  gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
  gem "fuelux-rails"

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

# To upload photo
gem 'paperclip', :git => "git://github.com/thoughtbot/paperclip.git"
# gem 'fog'
gem 'aws-sdk'
# gem 'aws-s3'

# Authentication
gem 'devise'

# facebook
gem "omniauth"
gem "omniauth-facebook"

# logical delete
gem "acts_as_paranoid"

# pager
gem "kaminari"

# web server
gem "unicorn"

# graph
gem "lazy_high_charts"
# gem "gruff"
# gem "rmagick" 

gem 'icheck-rails'

# country select
# gem "country-select"


# gem "jquery-fileupload-rails"
