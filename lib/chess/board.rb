require "matrix"
require "yaml"
class Matrix
  public :"[]=", :set_element, :set_component
end

class Board
  attr_reader :board
  def initialize
    @board = create_board
    puts "The ones you can see through are 'white', the full whites are 'black'."
  end

  def create_board
    m = Matrix.build(8,8) do |row, col|
      Tile.new(col, row)
    end
    m
  end

  def print_board
    for i in 0..7
      puts ""
      print "#{(8 - i)}"
      for j in 0..7
        print " #{@board[(i),j].to_s}"
      end
    end
    puts ""
    puts "  a b c d e f g h"
  end
  def production_move(origin, target, player_color)
    return false unless @board[origin[0],origin[1]].figure.owner == player_color
    make_move(origin, target)
  end

  def make_move(origin, target, hypothetical = false)
    #set variables and check legality of move
    return false if origin == target
    old_tile = @board[origin[0],origin[1]]
    return false unless old_tile.figure
    new_tile = @board[target[0],target[1]]
    figure = old_tile.figure
    return false unless figure.legal_move?(origin,target,@board)
    # save of state. reason: if after the move the mover is in check,
    # the move is declared illegal afterwards and reverted
    save = {
    origin_figure: figure,
    target_figure: new_tile.figure,
    fig_x_coord: figure.x,
    fig_y_coord: figure.y
    }
    #do actual move
    new_tile.figure = figure
    old_tile.figure = Empty.new
    figure.x = target[0]
    figure.y = target[1]
    if check?(figure.owner, hypothetical)
      puts "You can't do this, because it will leave your king in check" unless hypothetical
      old_tile.figure = save[:origin_figure]
      new_tile.figure = save[:target_figure]
      figure.x        = save[:fig_x_coord]
      figure.y        = save[:fig_y_coord]
      return false

    end
    if hypothetical
      old_tile.figure = save[:origin_figure]
      new_tile.figure = save[:target_figure]
      figure.x        = save[:fig_x_coord]
      figure.y        = save[:fig_y_coord]
    end
    return true
  end

  def checkmate?(player_color)
    @board.each_with_index do |e, row, col|
      if e.figure.owner == player_color
        # puts e.figure.name
        # puts e.figure.possible_moves([row,col],@board).to_s
        e.figure.possible_moves([row,col],@board).each do |move|
          return false if make_move([row,col], move, true)
        end
      end
    end
    true
  end

  def check?(player_color, hypothetical = false)
    #find king positions
    other_color = "black" if player_color == "white"
    other_color = "white" if player_color == "black"

    king_position = []
    @board.each_with_index do |tile, row, col|
      if tile.figure.name == "King" && tile.figure.owner == player_color
        king_position = [row,col]
      end
    end
    # puts "#{player_color} king:"
    # puts king_position

    #see if anyone can capture enemy king
    @board.each_with_index do |tile, row, col|
      if tile.figure.owner == other_color
        if tile.figure.legal_move?([row,col],king_position,@board)
          puts "#{other_color} #{tile.figure.name}(#{[row,col].to_s}) threats #{player_color} King(#{king_position})" unless hypothetical
          return true
        end
      end
    end
    return false
  end
end
