#contains game logic for the chess game
require "yaml"
class Game
  def initialize
    prompt_load
    @board ||= Board.new
    @white ||= Player.new("white")
    @black ||= Player.new("black")
    @current ||= @white
    @other ||= @black
  end
  def prompt_load
    puts "load old game?(y/n)"
    if gets.chomp[0].downcase == "y"
      load_yaml
    end
  end
  def start
    until @board.checkmate?(@current.color)
      @board.print_board
      puts "#{@current.name}, you are #{@current.color}. Make your move"

      puts "Enter coordinates of figure(or enter save or load):"
      raw_origin = gets.chomp
      if raw_origin == "save"
        save_yaml
        redo
      end
      if raw_origin == "load"
        load_yaml
        redo
      end
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
    puts "#{@other.name}(#{@other.color}) has won! #{@current.name} is checkmate!"
  end

  def load_yaml
    data = YAML.load_file('chess_save.yaml')
    # puts data.to_s
    @board = data[:board]
    @white = data[:white]
    @black = data[:black]
    @current = data[:current]
    @other  = data[:other]
    @board.board.each_with_index do |e, row, col|
      tile_key = "tile#{row}#{col}".to_sym
      figure_key = "figure#{row}#{col}".to_sym
      e = data[tile_key]
      e.figure = data[figure_key]
    end
    puts "data loaded! have fun :)"
  end
  def save_yaml
    data = {  }
    data[:board] = @board
    data[:white] = @white
    data[:black] = @black
    data[:current] = @current
    data[:other] = @other
    @board.board.each_with_index do |e, row, col|
      tile_key = "tile#{row}#{col}".to_sym
      figure_key = "figure#{row}#{col}".to_sym
      data[tile_key] = e
      data[figure_key] = e.figure
    end

    game_yaml = YAML::dump(data)
    File.open('chess_save.yaml', 'w') {|f| f.write game_yaml}
    puts "game saved!"
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
