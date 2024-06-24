require './lib/word_dictionary'

class Game
  attr_accessor :guesses, :word, :current_word, :letters, :choice, :word_length, :wrong_choices

  def initialize
    @wrong_choices = []
    get_new_word
    puts "Weclome to hangman!"
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
    print "Please choose a letter: "
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
      get_new_word
      display_letters
      inclusion_check
    elsif ans == 'n'
      puts "Have a nice day!"
      exit
    else
      puts "That's not a valid option."
      replay?
    end
  end
end
