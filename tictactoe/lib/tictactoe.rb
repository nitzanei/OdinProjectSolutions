class Grid
  @@x_symbol = 'X'
  @@o_symbol = 'O'

  def initialize(size = 3)
    @size = size
    @marked_cells = 0 #number of cells with marks. Starts as 0.
    #create 2 dimensional empty grid
    @marks = Array.new(@size) { Array.new(@size,' ')}
  end

  #adds a mark on the grid
  def add_mark(row, column, symbol)
    mark_added = false

    #verify the cell is empty
    if @marks[row][column] == ' '
      @marks[row][column] = symbol
      @marked_cells += 1 #increment number of marked cells
      mark_added = true
    else
      return false
    end
  end

  def print_grid
    @marks.each_index do |x|
      print @marks[x]
      puts
    end
  end

  def strike(for_symbol)

    #scan rows and columns
    for i in 0..@size-1
      #scan row i
      if @marks[i].join == (for_symbol * @size)
        return true
      end

      #scan column i
      temp_column_array = []
      for j in 0..@size-1
        if @marks[j][i] == for_symbol
          temp_column_array.push(for_symbol)
        end
      end
      if temp_column_array.join == (for_symbol * @size)
        return true
      end
    end

    #separate loop for dianonal strike check

    #check if strike exists and return true or false
    return false
  end

  def is_full
    (@marked_cells == @size**2) ? (return true) : (return false)
  end

  def self.x_symbol
    return @@x_symbol
  end

  def self.o_symbol
    return @@o_symbol
  end

end

class Player
  attr_accessor :name
  attr_reader :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def play_turn(with_grid)
    print "Select row (0 to 2):"
    row = gets.chomp.to_i
    print "Select column (0 to 2):"
    column = gets.chomp.to_i

    if !((0..2).include?(row))
      puts "Choose row/column between 0 and 2."
      return false
    end

    return with_grid.add_mark(row, column, @symbol)

  end


end

class Game
  def play(with_players)
    my_grid = Grid.new
    my_grid.print_grid
    turn_no = 1
    while !my_grid.is_full
      current_player = (turn_no.odd?) ? 0 : 1
      print "#{with_players[current_player].name}, it is your turn.\n"
      #Play turn for current player and increment turn number only if played correctly
      if with_players[current_player].play_turn(my_grid)
        my_grid.print_grid
        #check for strike after turn and return winner
        if my_grid.strike(with_players[current_player].symbol)
          #return current_player as winner
          return current_player
        end
        #no strike, next turn
        turn_no += 1
      else
        puts "Couldn't complete your turn. Please try again."
      end
    end

    return -1 #draw
  end
end

#Main

my_game = Game.new
play_again = 'Y'

#Create players
puts "Enter players names:"
players = [Player.new(gets.chomp, Grid.x_symbol),
           Player.new(gets.chomp, Grid.o_symbol)]
#Run game until quit
until play_again.upcase != 'Y'
  winner = my_game.play(players)
  (winner == -1) ? (puts "Draw!") : (puts "#{players[winner].name} wins!")
  puts "Play again? (Y/N)"
  play_again = gets.chomp
end
