require 'byebug'
require 'set'

class WordChainer
  def initialize(dictionary_file_name)
    @dictionary = Set.new(File.readlines(dictionary_file_name).map(&:chomp))
    @current_words = []
    @all_seen_words = {}
  end

  def run(source, target)
    @current_words.push(source)
    @all_seen_words[source] = nil

    until @current_words.empty?
      @current_words = explore_current_words(target)
      break if @current_words.last == target
    end
    p @all_seen_words
    path = build_path(target)
    p path
  end

  def explore_current_words(target)
    new_current_words = []
    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adj_word|
        next if @all_seen_words.include?(adj_word)
        new_current_words.push(adj_word)
        @all_seen_words[adj_word] = current_word
        return new_current_words if adj_word == target
      end
    end
    # p @all_seen_words
    new_current_words
  end

  def adjacent_words(word)
    adj_words = []
    alphabet = ('a'..'z').to_a
    word.chars.each_with_index do |word_letter, i|
      alphabet.each do |alph_letter|
        next if alph_letter == word_letter
        adj_word = word[0...i] + alph_letter + word[i+1..-1]
        adj_words << adj_word if @dictionary.include?(adj_word)
      end
    end
    adj_words
  end

  def build_path(target)
    path = []
    current_node = target
    until current_node.nil?
      path.unshift(current_node)
      current_node = @all_seen_words[current_node]
    end
    path
  end
end

if __FILE__ == $PROGRAM_NAME
  wc = WordChainer.new('./dictionary.txt')
  wc.run("market", "bother")
end
