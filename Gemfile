source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby "3.1.2"

gem "rails", "~> 7"
gem "sprockets-rails"
gem "puma"
gem "sass-rails"
gem "hotwire-rails"
gem "coffee-rails"
gem "jbuilder"
gem "redis", "~> 4.1"

group :development do
  gem "web-console"
  gem "faker"
  gem "listen"
end

group :development, :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "byebug"
end

group :test do
  gem "webmock", "~> 3.6"
  gem "vcr"
  gem "mocha"
end
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "html-pipeline"
gem "commonmarker"
gem "sanitize"
gem "kaminari"
gem "local_time"
gem "devise"
gem "pundit", "~> 2.1"
gem "pg"
gem "pg_search"
gem "mojang_api", "~> 0.0.2"
gem "friendly_id", "~> 5"
gem "sucker_punch"
gem "slack-notifier"
gem "chartkick"
gem "groupdate"
gem "trix-rails", require: "trix"
# Record Tag helper gem for div_for
gem "record_tag_helper", github: "rails/record_tag_helper"

gem "attr_encrypted", github: "PagerTree/attr_encrypted", branch: "rails-7-0-support"
gem "sshkey", "~> 2.0"
gem "net-ssh"

gem "standard", "~> 1.2"

gem "cssbundling-rails"
gem "jsbundling-rails"
