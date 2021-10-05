class Board
  attr_accessor :grid

  def initialize
    @grid = board_setup
  end

  def board_setup
    grid = {}
    1.upto(7) do |column|
      grid[column] = []
      1.upto(6) do |row|
        grid[column] << row
      end
    end
    grid
  end

  def display_board
    puts '-----------------------------'
    1.upto(6) do |i|
      grid.each do |column, array|
        character = array[i - 1].class == String ? array[i - 1] : ' '
        print "| #{character} |" if column == 1
        print " #{character} |" if column.between?(2, 6)
        print " #{character} |\n" if column == 7
      end
      puts '-----------------------------'
    end
    puts '  1   2   3   4   5   6   7  '
  end

  def board_full?
    grid.all? do |_, array|
      array.all? { |el| el.class == String }
    end
  end

  def winner?
  end

  def add_piece(column, symbol) #todo: extract position finding ?
    position = grid[column].inject { |memo, space| memo > space.to_i ? memo : space }
    available_index = grid[column].index(position)
    grid[column][available_index] = symbol
  end
end
