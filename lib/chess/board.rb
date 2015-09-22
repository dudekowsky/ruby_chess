require "matrix"

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

  def make_move(origin, target)
    return false if origin == target
    old_tile = @board[origin[0],origin[1]]
    return false unless old_tile.figure
    new_tile = @board[target[0],target[1]]
    figure = old_tile.figure
    return false unless figure.legal_move?(origin,target,@board)
    new_tile.figure = figure
    old_tile.figure = Empty.new
    figure.x = target[0]
    figure.y = target[1]
    true
  end
end
