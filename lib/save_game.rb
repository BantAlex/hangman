require 'csv'

class SaveGame
  attr_accessor :save_directory

  def initialize
    create_directory
  end

  def create_directory
    @save_directory = Dir.mkdir "./saved_game" unless Dir.exist? ".saved_game"
  end

end

SaveGame.new
