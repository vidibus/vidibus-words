# Vidibus::Words [![](http://travis-ci.org/vidibus/vidibus-words.png)](http://travis-ci.org/vidibus/vidibus-words)

This gem provides handling of words. It ships with a list of stop words in English, German, and Spanish and allows extraction of keywords from a string.

This gem is part of [Vidibus](http://vidibus.org), an open source toolset for building distributed (video) applications.


## Installation

Add `gem 'vidibus-words'` to your `Gemfile`. Then call `bundle install` on your console.


## Usage

### Extracting keywords

To return a list of keywords from a given text, ordered by occurrence, enter:

```ruby
input = Vidibus::Words.new('To tell a long story short, it\'s necessary to tell it briefly without fluff!')
input.keywords
 => ["tell", "long", "story", "short", "necessary", "briefly", "fluff"]
```

To return keywords of a certain locale only, you may set it as filter:

```ruby
input = Vidibus::Words.new('To tell a long story short, it\'s necessary to tell it briefly without fluff!')
input.locale = :de
input.keywords
 => ["to", "tell", "a", "long", "story", "short", "it's", "necessary", "it", "briefly", "without", "fluff"] 
```

### Stopwords lists

You may obtain stopwords easily:

```ruby
Vidibus::Words.stopwords      # => Stopwords for all available locales
Vidibus::Words.stopwords(:en) # => English stopwords only
```


## Copyright

&copy; 2010-2012 Andre Pankratz. See LICENSE for details.
