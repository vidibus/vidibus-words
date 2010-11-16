require "rails"
require "vidibus-core_extensions"

$:.unshift(File.join(File.dirname(__FILE__), "vidibus"))
require "words"

# Start a Rails Engine to load translations containing stopwords.
if defined?(Rails)
  module Vidibus
    module WordsEngine
      class Engine < ::Rails::Engine; end
    end
  end
end
