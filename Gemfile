source 'https://rubygems.org'
ruby '2.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

# DotEnv to load production pw and all that
gem 'dotenv-rails', group: :production

# Dashboard for managing resources
gem 'activeadmin', github: 'activeadmin'

# Use postgres as the database for Active Record
gem 'pg', group: :production
gem 'sqlite3', group: [:development, :test]

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Beautiful charts
gem "chartkick"
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment

gem 'dotenv'


  gem 'cancancan', '~> 1.10'
  gem 'devise'

gem 'rake'

group :production do
	# Use unicorn as the app server
	gem 'unicorn'
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'quiet_assets'
  gem 'spring'
end

# Use debugger
# gem 'debugger', group: [:development, :test]

group :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

group :development, :test do
  gem 'awesome_print'
  gem 'byebug'
  gem 'guard-rspec'
  gem 'rspec-rails'
end

