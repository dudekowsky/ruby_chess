class Empty
  def owner
    :none
  end
  def legal_move?(origin,target,board)
    false
  end

end
class Figure
  attr_reader :sign, :owner
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
end

class Pawn < Figure
  def name
    "Pawn"
  end
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
  def name
    "Bishop"
  end
  def find_sign
    if @owner == "white"
      return "\u2657"
    else
      return "\u265D"
    end
  end

  def legal_move?(origin, target, board)

    output = []
    i,j = origin[0],origin[1]
    #adds all possible tiles on the top-left
    while true
      break if i <= 0
      break if j <= 0
      i-= 1
      j-= 1
      break if board[i,j].figure.owner == @owner
      output.push([i,j])
      break if board[i,j].figure.owner == other_owner
    end
    #add all possible tiles on the bottom-left
    i,j = origin[0],origin[1]
    while true
      break if i >= 7
      break if j <= 0
      i+= 1
      j-= 1
      break if board[i,j].figure.owner == @owner
      output.push([i,j])
      break if board[i,j].figure.owner == other_owner
    end
    #add all possible tiles to the top-right
    i,j = origin[0],origin[1]
    while true
      break if i <= 0
      break if j >= 7
      i-= 1
      j+= 1
      break if board[i,j].figure.owner == @owner
      output.push([i,j])
      break if board[i,j].figure.owner == other_owner
    end
    #add all possible tiles to the bottom-right
    i,j = origin[0],origin[1]
    while true
      break if i >= 7
      break if j >= 7
      i+= 1
      j+= 1
      break if board[i,j].figure.owner == @owner
      output.push([i,j])
      break if board[i,j].figure.owner == other_owner
    end
    return true if output.include?(target)
    false
  end

end
class Knight < Figure
  def name
    "Knight"
  end
  def find_sign
    if @owner == "white"
      return "\u2658"
    else
      return "\u265E"
    end
  end
  def legal_move?(origin, target, board)
    output = []
    y = origin[0]
    x = origin[1]
    relative_moves = [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[1,-2],[-1,2],[-1,-2]]
    relative_moves.each do |relmove|
      total_move = [ relmove[0] + y, relmove[1] + x ]
      next if total_move[0] > 7 || total_move[0] < 0 || total_move[1] > 7 || total_move[1] < 0
      puts total_move.to_s
      output.push(total_move) if !(board[total_move[0],total_move[1]].figure.owner == @owner)
      puts output.to_s
    end
    return true if output.include?(target)
    false
  end
end
class King < Figure
  def name
    "King"
  end
  def find_sign
    if @owner == "white"
      return "\u2654"
    else
      return "\u265A"
    end
  end
  def legal_move?(origin, target, board)
    output = []
    y = origin[0]
    x = origin[1]
    relative_moves = [[1,1],[1,-1],[-1,1],[-1,-1],[1,0],[-1,0],[0,1,],[0,-1]]
    relative_moves.each do |relmove|
      total_move = [ relmove[0] + y, relmove[1] + x ]
      next if total_move[0] > 7 || total_move[0] < 0 || total_move[1] > 7 || total_move[1] < 0
      puts total_move.to_s
      output.push(total_move) if !(board[total_move[0],total_move[1]].figure.owner == @owner)
      puts output.to_s
    end
    return true if output.include?(target)
    false
  end
end
class Queen < Figure
  def name
    "Queen"
  end
  def find_sign
    if @owner == "white"
      return "\u2655"
    else
      return "\u265B"
    end
  end
  def legal_move?(origin, target, board)

    output = []

    #adds all possible tiles on the top-left
    i,j = origin[0],origin[1]
    while true
      break if i <= 0
      break if j <= 0
      i-= 1
      j-= 1

      break if board[i,j].figure.owner == @owner
      output.push([i,j])

      break if board[i,j].figure.owner == other_owner
    end
    puts output.to_s
    #add all possible tiles on the bottom-left
    i,j = origin[0],origin[1]
    while true
      break if i >= 7
      break if j <= 0
      i+= 1
      j-= 1
      break if board[i,j].figure.owner == @owner
      output.push([i,j])
      break if board[i,j].figure.owner == other_owner
    end
    puts output.to_s
    #add all possible tiles to the top-right
    i,j = origin[0],origin[1]
    while true
      break if i <= 0
      break if j >= 7
      i-= 1
      j+= 1
      break if board[i,j].figure.owner == @owner
      output.push([i,j])
      break if board[i,j].figure.owner == other_owner
    end

    #add all possible tiles to the bottom-right
    i,j = origin[0],origin[1]
    while true
      break if i >= 7
      break if j >= 7
      i+= 1
      j+= 1
      break if board[i,j].figure.owner == @owner
      output.push([i,j])
      break if board[i,j].figure.owner == other_owner
    end
    puts "schräg abgehakt"
    puts output.to_s
    #adds all possible tiles on the top
    i,j = origin[0],origin[1]
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
    puts "gerade abgehakt"
    puts output.to_s
    puts target.to_s
    return true if output.include?(target)
    false
  end
end
