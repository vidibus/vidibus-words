require "active_support/core_ext"
require "vidibus-core_extensions"

$:.unshift(File.join(File.dirname(__FILE__), "vidibus"))
require "words"

if defined?(Rails)
  module Vidibus::Words
    class Engine < ::Rails::Engine; end
  end
end
