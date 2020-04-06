source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.0"

gem "rails"
gem "pg"
gem "puma"
gem "webpacker"

gem "bootsnap", require: false
gem "standard"
gem "query_diet", require: false

group :development, :test do
  gem "dotenv-rails"
end

group :development do
  gem "web-console"
  gem "listen"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
