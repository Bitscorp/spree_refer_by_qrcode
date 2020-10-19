source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'spree', github: 'spree/spree', branch: 'master'
gem 'spree_auth_devise', '~> 4.1'

gem 'rqrcode'

group :test do
  gem 'sqlite3'

  gem 'rails-controller-testing'

  gem 'database_cleaner'
  gem 'ffaker'
  gem 'factory_bot'

  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-stack_explorer', '~> 0.5.0'

  gem 'rspec'
  gem 'rspec-rails'
end

gemspec
