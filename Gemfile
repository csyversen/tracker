source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 4'

# Use mysql as the database for Active Record
gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass-rails', '>= 4'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '>= 4'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '>= 3'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'bootstrap-sass', '~> 2'
gem 'public_suffix'
#gem 'nokogiri'
gem 'faker'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'amazon-ecs'
gem 'd3-rails'
gem 'gon'
# These 4 gems might need to go into the dev group only
gem 'rest_client'
gem 'json'
#gem 'amazon-ecs'
#gem 'yaml'


group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'guard-rspec'
end

group :test do
  gem 'factory_girl_rails'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner' #, github: 'bmabey/database_cleaner'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
