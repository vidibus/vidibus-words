# encoding: utf-8
module Vidibus
  class Words

    class MissingLocaleError < StandardError; end

    def initialize(input, loc = [])
      @input = input
      self.locale = loc
    end

    def input
      @input
    end

    # Sets locale(s) to be used.
    def locale=(input)
      input = [input] unless input.is_a?(Array)
      @locales = input
    end

    def locales
      @locales || []
    end

    # Returns words from input input.
    def list
      @list ||= Vidibus::Words.words(input)
    end
    alias_method :to_a, :list

    # Returns words ordered by usage.
    def sort
      @sort ||= Vidibus::Words.sort_by_occurrence(list)
    end

    # Returns top keywords from input string.
    def keywords(limit = 20)
      @keywords ||= {}
      @keywords[limit] ||= begin
        list = []
        count = 0
        _stopwords = Vidibus::Words.stopwords(*locales)
        for word in sort
          clean = word.permalink.gsub("-","")
          unless _stopwords.include?(clean)
            list << word
            count += 1
            break if count >= limit
          end
        end
        list
      end
    end

    class << self

      # Returns a list of all stop words for given locale(s).
      # If no locales are given, all available will be used.
      def stopwords(*locales)
        locales = I18n.available_locales if locales.empty?
        stopwords = []
        for locale in locales
          translation = I18n.t("vidibus.stopwords", :locale => locale)
          next if translation.is_a?(String)
          stopwords << translation
        end
        stopwords.flatten.uniq
      end

      # Returns a list of words from given string.
      def words(string)
        allowed = [" ", "a-z", "A-Z", "0-9"] + String::LATIN_MAP.values
        disallowed = ["¿", "¡"] # Add some disallowed chars that cannot be catched. TODO: Improve!
        match = /[^#{allowed.join("")}]/
        string.
          gsub(/\s+/mu, " ").
          gsub(/[#{disallowed.join}]/u, "").
          gsub(/#{match}+ /u, " ").
          gsub(/ #{match}+/u, " ").
          gsub(/#{match}+$/u, "").
          gsub(/^#{match}+/u, "").
          split(/ /)
      end

      # Returns a list of words ordered by occurrence.
      # All words will be converted to downcase.
      def sort_by_occurrence(list)
        map = {}
        count = [999, list.length].min
        for word in list
          word.downcase!
          map[word] ||= count
          map[word] += 1000
          count -= 1 if count > 0
        end
        map.to_a.sort_by {|x| -x.last}.map {|x| x.first}
      end
    end
  end
end
