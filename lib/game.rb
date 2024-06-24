require './lib/word_dictionary'

class Game

  attr_accessor :guesses, :word, :current_word, :letters, :choice

  def initialize
    self.guesses = 15
    get_new_word
    puts "Weclome to hangman!"
    puts ""
    puts "A random word will be selected and you you're gonna try to guess it!"
    puts ""
    puts "The word will contain 5-12 letters."
    puts ""
    display_letters
    get_choice
  end


  def get_new_word
    @word = WordDictionary.new
    @current_word = word.get_random_word
    @letters = Array.new(current_word[0].length,"_ ")
  end

  def display_letters
    puts current_word #*this should be deleted when done
    puts @letters.join
  end

  def get_choice
    puts "Please choose a letter"
    @choice = gets.chomp.downcase

    return @choice if ('a'..'z').include?(@choice) || ('A'..'Z').include?(@choice)

    puts ""
    puts "That's not a valid option."
    puts ""
    get_choice
  end

  def inclusion_check

  end

end


play = Game.new
