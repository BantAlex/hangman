require './lib/word_dictionary'
require './lib/save_game'
require 'yaml'

class Game < SaveGame
  attr_accessor :guesses, :word, :current_word, :letters, :choice, :word_length, :wrong_choices, :saved_info

  def initialize
    puts "==Ruby Hangman Game=="
  end

  def new_game
    @wrong_choices = []
    get_new_word
    puts ""
    puts "A random word will be selected and you're gonna try to guess it!"
    puts ""
    puts "The word will contain 5-12 letters."
    puts ""
    puts "You have #{guesses} tries."
    puts ""
    display_letters
    inclusion_check
  end

  def get_new_word
    @guesses = 15
    @word = WordDictionary.new
    @current_word = word.get_random_word[0]
    @word_length = current_word.length
    @letters = Array.new(@word_length,"_ ")
  end

  def display_letters
    puts @letters.join
    get_choice
  end

  def get_choice
    word_found?
    puts ""
    puts "You can save the game by typing 'save'"
    print "Please choose a letter or save the game: "
    @choice = gets.chomp.downcase

    save_game if @choice == 'save'
    inclusion_check if ('a'..'z').include?(@choice) || ('A'..'Z').include?(@choice)

    puts ""
    puts "That's not a valid option."
    puts ""
    get_choice
  end

  def inclusion_check
    if !@current_word.include?(@choice)
      @guesses -= 1
      display_wrong_choices
      out_of_guesses?
      puts ""
      puts "Nope!"
      puts ""
      puts "You have #{guesses} tries left."
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
      puts " "
      puts "You lost!"
      puts "The word was '#{@current_word}'"
      replay?
    end
  end

  def display_wrong_choices
   @wrong_choices.push(@choice) unless @wrong_choices.include?(@choice)
   puts "Wrong letters: #{@wrong_choices}"
  end

  def save_game
    SaveGame.new(@current_word,@letters,@guesses,@wrong_choices)
    puts "See ya soon"
    exit
  end

  def load_game
    @saved_info = YAML.load_file('./saved_game/saved_file.yaml')
    @current_word = @saved_info[:word]
    @letters = @saved_info[:letters]
    @guesses = @saved_info[:tries_left]
    @wrong_choices = @saved_info[:wrong_choices]
    puts "Welcome back!"
    puts ""
    display_letters
    inclusion_check
  end

  def word_found?
    if @letters == @current_word.split("")
      puts ""
      puts "Congrats! You found the word!"
      replay?
    end
  end

  def replay?
    puts "Would you like to play again with a new word?(y/n)"
    ans = gets.chomp.downcase

    if ans == 'y'
      new_game
    elsif ans == 'n'
      puts "Have a nice day!"
      exit
    else
      puts "That's not a valid option."
      replay?
    end
  end
end
