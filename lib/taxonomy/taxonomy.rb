module Taxonomy
  class Taxonomy
    attr_reader :dict
    def initialize(options)
      file = options.fetch(:file)
      taxonomy = YAML.load(File.new(file))
      # Dictionary containing all possible combinations,
      # i.e. name, synonyms, misspellings
      dict = {}
      @max_ngrams = 1 # Find out the maximum amount of ngrams we need
      # Create a hash for reverse lookup of class
      taxonomy.each do |word|
        name = word['name'].downcase.strip.to_sym
        combinations = []
        synonyms = word['synonyms'] 
        misspellings = word['misspellings'] 
        combinations.concat synonyms if synonyms
        combinations.concat misspellings if misspellings
        combinations = combinations.map(&:downcase).map(&:strip)
        combinations << name
        combinations.uniq.each do |combination|
          ngram_count = Ngram.new(combination.to_s).ngram_tokenize.size
          @max_ngrams = ngram_count if ngram_count > @max_ngrams
          dict[combination.to_sym] = OpenStruct.new(word)
        end
        #word['combinations'] = combinations
      end
      @dict = dict
    end

    def [](key)
      @dict[key]
    end

    def classify(text, options={})
      only_names = options.fetch(:only_names, true)
      group = options[:group]
      parent = options[:parent]
      ngrams = Ngram.new(text).ngrams(1..@max_ngrams)
      if only_names
        res = []
        ngrams.each do |word|
          word = word.downcase.to_sym
          match = @dict[word]
          match = nil if match && group && match.group != group 
          match = nil if match && parent && match.parent != parent 
          res << match.name if match
        end
      else
        res = {}
        ngrams.each do |word|
          word = word.downcase.to_sym
          match = @dict[word]
          match = nil if match && group && match.group != group 
          match = nil if match && parent && match.parent != parent 
          res[match.name] = match if match
        end
      end
      res
    end
  end
end
