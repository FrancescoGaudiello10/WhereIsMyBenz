ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'devise'
require 'rspec/autorun'
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f } #Require everything in support folder


RSpec.configure do |config|
    config.use_transactional_fixtures = false

    config.before(:suite) do
        DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
        DatabaseCleaner.strategy = :transaction
    end

    config.before(:each, :js => true) do
        DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
        DatabaseCleaner.start
    end

    config.after(:each) do
        DatabaseCleaner.clean
    end

    config.expect_with :rspec do |expectations|

        expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    end

    config.mock_with :rspec do |mocks|

        mocks.verify_partial_doubles = true
    end

    config.shared_context_metadata_behavior = :apply_to_host_groups
    
    config.include Devise::Test::ControllerHelpers, :type => :controller
    config.include ControllerMacros, :type => :controller
end
