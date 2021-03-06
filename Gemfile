source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
gem 'rails', '~> 5.1.4'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'pg', '0.18'
gem 'figaro'
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'simple_form', '~> 3.5.0'
gem 'font-awesome-sass'
gem 'slim-rails'
gem 'high_voltage', '~> 3.0.0'
gem 'carrierwave'
gem 'carrierwave-upyun'
gem 'status-page'
gem 'browser_warrior'
gem 'redis-namespace'
gem 'sidekiq'
gem 'kaminari', '~> 1.0.1'
gem 'rails-i18n', '~> 5.0.3'
gem 'mina', '~> 1.2.2', require: false
gem 'mina-puma', '~> 1.1.0', require: false
gem 'mina-multistage', '~> 1.0.3', require: false
gem 'mina-sidekiq', '~> 1.0.3', require: false
gem 'mina-logs', '~> 1.1.0', require: false
gem 'lograge'
gem 'ransack'
gem 'awesome_rails_console'


gem 'adminlte-rails', github: '80percent/adminlte-rails', tag: 'v2.3.11'
gem 'active_link_to'
gem 'bcrypt'
gem 'http', '~> 2.2'
gem 'jwt', '~> 1.5'

group :development do
  gem 'rails_apps_testing'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :test do
  gem 'database_cleaner'
  gem 'launchy'
end
