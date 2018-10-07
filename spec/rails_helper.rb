# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require 'paperclip/matchers'
require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'
require 'capybara/rspec'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

Capybara.register_driver :selenium do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    'desiredCapabilities' => { 'takesScreenshot' => false }, # Headless don't play screenshots yet
    'chromeOptions' => { 'args' => ['no-sandbox', 'disable-extensions', 'disable-gpu', 'disable-plugins',
      'test-type', 'headless', 'incognito', 'window-size=1280x1024'] }
  )
  Capybara::Selenium::Driver.new(app,
    browser: :remote,
    url: "http://chromedriver:4444", 
    desired_capabilities: capabilities)  
end

Capybara.javascript_driver = ENV['DOCKER'] ? :selenium : :webkit
Capybara.server_host = '0.0.0.0'
Capybara.server_port = 3000
Capybara.app_host = 'http://test:3000'
Capybara.configure do |config|
  config.server = :puma
end

Capybara::Webkit.configure do |webkit_config|
  webkit_config.block_unknown_urls
  webkit_config.allow_url('fonts.googleapis.com')
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :rspec

    # Or, choose the following (which implies all of the above):
    with.library :rails
  end
end

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.extend ControllerMacros, type: :controller
  config.include FactoryBot::Syntax::Methods
  config.include Paperclip::Shoulda::Matchers

  config.before :suite do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.around :each do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!
end
