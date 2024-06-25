require 'yaml'

class SaveGame
  attr_accessor :save_directory, :saved_data, :to_yaml

  def initialize(word,letters,tries,wrong_choices)
    create_directory
    saved_data = {word: word, letters: letters, 'tries_left': tries,'wrong_choices': wrong_choices}
    @to_yaml = YAML.dump(saved_data)
    create_save
  end

  def create_directory
    @save_directory = Dir.mkdir "./saved_game" unless Dir.exist? "./saved_game"
  end

  def create_save
    File.open('./saved_game/saved_file.yaml', 'w') do |file|
      file.write(@to_yaml)
    end
  end

end
