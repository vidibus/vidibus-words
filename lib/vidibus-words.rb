require 'vidibus/words'

# Start a Rails Engine to load translations containing stopwords.
if defined?(Rails)
  module Vidibus
    module WordsEngine
      class Engine < ::Rails::Engine; end
    end
  end
end
