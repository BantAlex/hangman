require './lib/game'
require './lib/load_game'

def load?
  play = Game.new
  play.new_game unless File.exist? './saved_game/saved_file.yaml'
  puts "Welcome back!"
  puts "Would you like to load your previous try or start a new game? (load/new)"
  ans = gets.chomp.downcase

  if ans == 'load'
    puts ""
    play.load_game
  elsif ans == 'new'
    puts ""
    play.new_game
  else
    puts "That's not a valid option"
    load?
  end
end

load?
