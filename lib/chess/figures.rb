class Figure
  attr_reader :name, :sign, :owner, :sign
  def initialize(x,y)
    @x = x
    @y = y
    @owner = find_owner(y)
    @sign = find_sign
  end

  def find_sign

  end


  def find_owner(y)
    if y < 3
      "white"
    else
      "black"
    end
  end
end

class Rook < Figure
  def find_sign
    if owner == "white"
      return "\u2656"
    else
      return @sign = "\u265C"
    end
  end
end

class Pawn < Figure
  def find_sign
    if owner == "white"
      return "\u2659"
    else
      return "\u265F"
    end
  end
end
class Bishop < Figure
  def find_sign
    if owner == "white"
      return "\u2657"
    else
      return "\u265D"
    end
  end
end
class Knight < Figure
  def find_sign
    if owner == "white"
      return "\u2658"
    else
      return "\u265E"
    end
  end
end
class King < Figure
  def find_sign
    if owner == "white"
      return "\u2654"
    else
      return "\u265A"
    end
  end
end
class Queen < Figure
  def find_sign
    if owner == "white"
      return "\u2655"
    else
      return "\u265B"
    end
  end
end
