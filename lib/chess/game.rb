#contains game logic for the chess game
class Game
  def initialize
    @board = Board.new
    @white = Player.new("white")
    @black = Player.new("black")
    @current, @other = @white, @black
  end
  def start
    puts "#{@current.name}, you are #{@current.color}. Make your move"
  end
end
