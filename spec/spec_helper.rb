$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "rubygems"
require "rspec"
require "rr"
require "active_support/core_ext"
require "vidibus-core_extensions"
require "vidibus-words"

RSpec.configure do |config|
  config.mock_with :rr
end

I18n.load_path += Dir[File.join('config', 'locales', '**', '*.{rb,yml}')]
