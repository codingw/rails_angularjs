ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'capybara/rspec'
require 'rspec/rails'
require 'shoulda/matchers'
# require 'declarative_authorization/maintenance'
require 'socket'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

SELENIUM_SERVER = '127.0.0.1'
CAPYBARA_DEFAULT_HOST = "localhost"

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :remote, url: "http://#{SELENIUM_SERVER}:4444/wd/hub", desired_capabilities: :firefox)
end

Capybara.javascript_driver = :selenium

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.order = "random"
  config.use_transactional_fixtures = false
  config.raise_errors_for_deprecations!

  CAPYBARA_DEFAULT_PORT = 3005

  Capybara.default_host = "http://#{CAPYBARA_DEFAULT_HOST}"
  Capybara.server_port = CAPYBARA_DEFAULT_PORT
  Capybara.app_host = "http://#{CAPYBARA_DEFAULT_HOST}:#{Capybara.server_port}"

  config.before :each do |example|
    if Capybara.current_driver == :rack_test
      DatabaseCleaner.strategy = :transaction
    else
      DatabaseCleaner.strategy = :truncation
    end

    DatabaseCleaner.start

    if example.metadata[:type] == :request && example.metadata[:js].to_s == 'true'
      page.driver.browser.manage.window.maximize
    end

  end

  config.after do |example|
    DatabaseCleaner.clean
    Capybara.app_host = "http://#{CAPYBARA_DEFAULT_HOST}:#{Capybara.server_port}"

    if example.exception && example.metadata[:type] == :request
      now = DateTime.now
      filename = "tmp/" + example.metadata[:file_path].parameterize + "-#{now}.html"
      File.open(filename, 'w') {|f| f.write Capybara.page.html }
    end
  end

  config.include Capybara::DSL, type: :request
  # config.include Devise::TestHelpers, type: :controller
  # config.include Authorization::TestHelper, type: :controller

end

def mock_paginate(object)
  pager = double
  allow(pager).to receive(:per).and_return object

  allow(object).to receive(:current_page).and_return(1)
  allow(object).to receive(:total_pages).and_return(1)
  allow(object).to receive(:limit_value).and_return(1)
  allow(object).to receive(:page).and_return pager

  object
end

