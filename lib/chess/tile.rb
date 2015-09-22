class Tile
  attr_reader :color, :figure
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
    return @figure.sign unless @figure == nil
    return color
  end

  def set_figure(x,y)

      # b1: :knight,
      # c1: :bishop,
      # d1: :queen,
      # e1: :king,
      # f1: :bishop,
      # g1: :knight,
      # h1: :rook,
      #
      # a8: :rook,
      # b8: :knight,
      # c8: :bishop,
      # d8: :queen,
      # e8: :king,
      # f8: :bishop,
      # g8: :knight,
      # h8: :rook,

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
    end
  end

end
