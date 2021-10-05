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
    p grid
  end

  def board_full?; end

  def add_piece(column, symbol) #todo: extract position finding ?
    position = grid[column].inject { |memo, space| memo > space.to_i ? memo : space }
    available_index = grid[column].index(position)
    grid[column][available_index] = symbol
  end
end
