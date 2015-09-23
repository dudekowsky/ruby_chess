#contains game logic for the chess game
class Game
  def initialize
    @board = Board.new
    @white = Player.new("white")
    @black = Player.new("black")
    @current, @other = @white, @black
  end
  def start
    until @board.checkmate?(@current.color)
      @board.print_board
      puts "#{@current.name}, you are #{@current.color}. Make your move"

      puts "Enter coordinates of figure:"
      raw_origin = gets.chomp
      puts "Enter coordinates of target:"
      raw_target = gets.chomp

      target = codify(raw_target)
      origin = codify(raw_origin)

      if target && origin
        if @board.production_move(origin, target, @current.color)
          switch_players
        else
          puts "illegal move, try again"
        end
      else
        puts "illegal coordinates: enter something like 'a1' or 'g4' (without quotation marks)"
      end
    end
  end

  def switch_players
    @current, @other = @other, @current
  end
  def codify(coordinates)
    x = coordinates[0].downcase.ord - 97

    y = 8 - coordinates[1].to_i
    return false unless y >= 0 && y <= 7 && x >= 0 && x <= 7
    # puts [y,x].to_s
    [y,x]
  end
end
