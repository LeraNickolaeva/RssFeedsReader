require 'capybara/rspec'
require 'capybara/rails'

Capybara.default_wait_time = 5
Capybara.javascript_driver = :webkit
Capybara.ignore_hidden_elements = true
