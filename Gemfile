source 'https://rubygems.org'

ruby '2.1.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.1.1'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
gem 'twitter-bootstrap-rails', '~> 2.2.8'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 2.5.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.1'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', '~> 0.12.1', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 3.1.0'
gem 'blockuijs-rails',  :git => 'git://github.com/rusanu/blockuijs-rails.git'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '2.2.2'

gem 'httparty', '0.13.1'
gem 'kaminari', '~> 0.15.1'
gem 'newrelic_rpm', '~> 3.8.0.218'
gem 'open_uri_redirections', '~> 0.1.4'
gem 'unicorn', '~> 4.8.3'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  gem "spring-commands-rspec"
end

group :test do
  gem 'coveralls', '~> 0.7.0', require: false
  gem "webmock", '~> 1.17.4'
	gem "mocha", '~> 1.0.0'
  gem "rspec-rails", '~> 2.14.2'
  gem 'factory_girl_rails', '~> 4.4.1'
end

group :production do
  gem 'rails_12factor', '~> 0.0.2'
end