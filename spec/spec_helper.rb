require 'simplecov'
SimpleCov.start

$:.unshift File.expand_path('../../', __FILE__)

require 'rubygems'
require 'rspec'
require 'rr'
require 'active_support/core_ext'
require 'vidibus-words'

RSpec.configure do |config|
  config.mock_with :rr
end

I18n.load_path += Dir[File.join('config', 'locales', '**', '*.{rb,yml}')]
