class Player
  attr_reader :name, :color
  def initialize(color)
    @color = color
    @name = name_prompt(color)
  end

  def name_prompt(color)
    puts "Hello! #{color.capitalize}, please enter your name."
    name = gets.chomp
    name
  end
end
