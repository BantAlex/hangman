require './lib/word_dictionary'

class Game

  attr_accessor :guesses, :word, :current_word, :letters, :choice, :word_length

  def initialize
    @guesses = 15
    get_new_word
    puts "Weclome to hangman!"
    puts ""
    puts "A random word will be selected and you you're gonna try to guess it!"
    puts ""
    puts "The word will contain 5-12 letters."
    puts ""
    puts "You have #{guesses}."
    puts ""
    display_letters
    inclusion_check
  end


  def get_new_word
    @word = WordDictionary.new
    @current_word = word.get_random_word[0]
    @word_length = current_word.length
    @letters = Array.new(@word_length,"_ ")
  end

  def display_letters
    # puts current_word #*this should be deleted when done
    puts @letters.join
    get_choice
  end

  def get_choice
    puts "Please choose a letter"
    @choice = gets.chomp.downcase

    inclusion_check if ('a'..'z').include?(@choice) || ('A'..'Z').include?(@choice)

    puts ""
    puts "That's not a valid option."
    puts ""
    get_choice
  end

  def inclusion_check
    if !@current_word.include?(@choice)
      @guesses -= 1
      out_of_guesses?
      puts ""
      puts "Nope!"
      puts ""
      puts "You have #{guesses} left."
      puts ""
      display_letters
    else
      put_choice_to_word
    end
  end

  def put_choice_to_word
    @current_word.each_char.with_index do |letter,i|
      @letters[i] = choice if letter == choice
    end
    display_letters
  end

  def out_of_guesses?
    if @guesses == 0
      puts "You lost!"
      puts "The word was '#{@current_word}'"
      exit
    end
  end

end


play = Game.new
