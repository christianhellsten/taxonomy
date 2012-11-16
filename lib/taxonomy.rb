require 'taxonomy/version'
require 'taxonomy/taxonomy'
require 'taxonomy/ngram'
require 'yaml'

module Taxonomy
  def self.load(file)
    Taxonomy.new(file: file)
  end
end
