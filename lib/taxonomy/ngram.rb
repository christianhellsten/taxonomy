require 'set'

module Taxonomy
  #
  # Extract uni, bi, and trigrams.
  #
  # "one two three".ngram(1) # unigrams
  # "one two three".ngram(2) # bigrams
  # "one two three".ngram(3) # trigrams
  # "one two three".ngrams(1..3) # unigrams, bigrams, trigrams
  #
  class Ngram
    REGEX = /\w+/
    def initialize(text)
      @text = text
    end

    def ngram_tokenize
       @text.downcase.scan(REGEX)
    end

    def ngram(n=1)
      raise ArgumentError, "Not a valid ngram #{n}" if n < 1
      res = Set.new
      words = ngram_tokenize
      word_count = words.length
      words.each_with_index do |word, ix|
        min = ix
        max = ix + (n-1)
        break if word_count <= max
        res.add words[min..max].join(' ')
      end
      res
    end

    def ngrams(range=1..3)
      return ngram(range) if range.is_a?(Fixnum)
      res = Set.new
      range.each do |n|
        res.merge ngram(n)
      end
      res.to_a
    end
  end
end
