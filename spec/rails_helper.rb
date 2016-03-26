ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'
require 'support/database_cleaner'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  # config.around(:each, js: true) do |example|
  #   DatabaseCleaner.strategy = :truncation
  #   ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
  #   example.run
  #   ActiveRecord::Base.shared_connection = nil
  # end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    with.library :rails
  end
end

def create_and_stub_admin
  admin = User.create(first_name: "john",
                      last_name: "adams",
                      email:     "admin@example.com",
                        password: 'password',
                        role: 1
                        )
  ApplicationController.any_instance.stub(:current_user) {admin}
  admin
end
