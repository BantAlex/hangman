class WordDictionary
 attr_accessor :word_array, :dictionary

  def initialize
    self.word_array = []
    self.dictionary = File.open('google-10000-english-no-swears.txt')
  end

  def create_word_array
    File.readlines(dictionary).each do |word|
      word = word.strip
      word_array.push(word) if word.length >= 5 && word.length <= 12
      next
    end
    word_array
  end

  def get_random_word
    create_word_array.sample(1)
  end

end
