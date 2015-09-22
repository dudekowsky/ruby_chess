class Empty
  def owner
    :none
  end
  def legal_move?(origin,target,board)
    false
  end

end
class Figure
  attr_reader :sign, :owner, :sign
  attr_accessor :x, :y
  def initialize(x,y)
    @x = x
    @y = y
    @owner = find_owner(y)
    @sign = find_sign
  end

  def find_sign

  end

  def move(origin, target)

  end

  def find_owner(y)
    if y < 3
      "black"
    else
      "white"
    end
  end
  def other_owner
    return "black" if @owner == "white"
    return "white" if @owner == "black"
  end
end


class Rook < Figure
  def name
    "Rook"
  end
  def find_sign
    if @owner == "white"
      return "\u2656"
    else
      return @sign = "\u265C"
    end
  end

  def legal_move?(origin, target, board)

    output = []
    i,j = origin[0],origin[1]
    #adds all possible tiles on the top
    while true
      break if i <= 0
      i-= 1
      break if board[i,j].figure.owner == @owner
      output.push([i,j])
      break if board[i,j].figure.owner == other_owner
    end
    #add all possible tiles on the bottom
    i,j = origin[0],origin[1]
    while true
      break if i >= 7
      i+= 1
      break if board[i,j].figure.owner == @owner
      output.push([i,j])
      break if board[i,j].figure.owner == other_owner
    end
    #add all possible tiles to the left
    i,j = origin[0],origin[1]
    while true
      break if j <= 0
      j-= 1
      break if board[i,j].figure.owner == @owner
      output.push([i,j])
      break if board[i,j].figure.owner == other_owner
    end
    #add all possible tiles to the right
    i,j = origin[0],origin[1]
    while true
      break if j >= 7
      j+= 1
      break if board[i,j].figure.owner == @owner
      output.push([i,j])
      break if board[i,j].figure.owner == other_owner
    end
    return true if output.include?(target)
    false
  end

  def possible_moves(origin)

  end


end

class Pawn < Figure
  def initialize(x,y)
    super
    @moves = 0
  end
  def find_sign
    if @owner == "white"
      return "\u2659"
    else
      return "\u265F"
    end
  end
  def legal_move?(origin, target, board)
    output = []
    y = origin[0]
    x = origin[1]
    #white pawn goes into other direction than black pawn
    if @owner == "black"
      puts "black pawn"
      #move downward two if first move
      output.push([y+2,x]) if !board[y+2,x].nil? && (board[y+1,x].figure.owner == :none &&
                              board[y+2,x].figure.owner == :none && (@moves == 0))
      #move downward
      output.push([y+1,x]) if !board[y+1,x].nil? && board[y+1,x].figure.owner == :none
      #take left-downward
      output.push([y+1,x-1]) if !board[y+1,x-1].nil? && board[y+1,x-1].figure.owner == other_owner
      #take right-downward
      output.push([y+1,x+1]) if !board[y+1,x+1].nil? && board[y+1,x+1].figure.owner == other_owner
    else
      puts "white pawn"
      #move upward two if first move
      output.push([y-2,x]) if !board[y-2,x].nil? && (board[y-2,x].figure.owner == :none) &&
                              (@moves == 0)
      #move upward
      output.push([y-1,x]) if !board[y-1,x].nil? && board[y-1,x].figure.owner == :none
      #take left-upward
      output.push([y-1,x-1]) if !board[y-1,x-1].nil? && board[y-1,x-1].figure.owner == other_owner
      #take right-upward
      output.push([y-1,x+1]) if !board[y-1,x+1].nil? && board[y-1,x+1].figure.owner == other_owner
    end

    @moves += 1 if output.include?(target)
    return true if output.include?(target)
    false
  end

end
class Bishop < Figure
  def find_sign
    if @owner == "white"
      return "\u2657"
    else
      return "\u265D"
    end
  end
end
class Knight < Figure
  def find_sign
    if @owner == "white"
      return "\u2658"
    else
      return "\u265E"
    end
  end
end
class King < Figure
  def find_sign
    if @owner == "white"
      return "\u2654"
    else
      return "\u265A"
    end
  end
end
class Queen < Figure
  def find_sign
    if @owner == "white"
      return "\u2655"
    else
      return "\u265B"
    end
  end
end
