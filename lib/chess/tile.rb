class Tile
  attr_reader :color
  attr_accessor :figure
  def initialize(x, y)
    @x = x
    @y = y
    @color = color
    @figure = set_figure(x,y)
  end

  def position
    {x: @x, y: @y}
  end

  def color
    if (@x + @y) % 2 == 0
      "\u25A0"
    else
      "\u25A1"
    end
  end
  def to_s
    return @figure.sign unless @figure.owner == :none
    return color
  end

  def set_figure(x,y)
    if (x%7 == 0) && ((y%7 == 0))
      return Rook.new(x,y)
    elsif (y == 1) || (y == 6)
      return Pawn.new(x,y)

    elsif (((y == 0) || (y == 7)) && ((x == 2) || (x == 5)))
      return Bishop.new(x,y)

    elsif (((y == 0) || (y == 7)) && ((x == 1) || (x == 6)))
      return Knight.new(x,y)

    elsif (((y == 0) || (y == 7)) && (x == 3))
      return Queen.new(x,y)
    elsif (((y == 0) || (y == 7)) && (x == 4))
      return King.new(x,y)
    else
      Empty.new
    end
  end

end
