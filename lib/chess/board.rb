require "matrix"

class Matrix
  public :"[]=", :set_element, :set_component
end

class Board
  def initialize
    @board = create_board
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
        print " #{@board[i,j].to_s}"
      end
    end
    puts ""
    puts "  a b c d e f g h"
  end
end
