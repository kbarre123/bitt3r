source 'https://rubygems.org'
ruby '2.0.0'
# ruby-gemset=bitt3r

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Twitter Bootstrap with sass
gem 'bootstrap-sass', '2.3.2.0'

# Password hashing gem
gem 'bcrypt-ruby', '3.1.2'

# Make test users
gem 'faker', '1.1.2'

# Pagination
gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate', '0.0.9'

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '1.3.8'
  # Use rspec for testing
  gem 'rspec-rails', '2.13.1'
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.1.0'
  gem 'factory_girl_rails', '4.2.1'
  gem 'cucumber-rails', '1.4.0', :require => false
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
  
  # Uncomment this line on OSX
  # gem 'growl', '1.0.3'
  
  # Uncomment this line on Linux
  gem 'libnotify', '0.8.0'
  
  # Uncomment these lines on Windows
  # gem 'rb-notifu', '0.0.4'
  # gem 'win32console', '1.3.2'
  # gem 'wdm', '0.1.0' 
end

group :production do
  # user PostgreSQL database on Heroku
  gem 'pg', '0.15.1'
  # Needed to serve static assets on Heroku
  gem 'rails_12factor', '0.0.2'
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '2.1.1'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '4.0.1'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# Needed to serve asset pipeline without Node.js
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '3.0.4'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '1.1.1'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '1.0.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '0.3.20', require: false
end
