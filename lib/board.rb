require 'pry'

class Board
  attr_accessor :grid

  def initialize
    @grid = board_setup
  end

  def board_setup
    grid = {}
    1.upto(7) do |column|
      grid[column] = []
      # 1.upto(6) do |row|
      #   grid[column] << row
      # end
      value = column
      6.times do
        grid[column] << value
        value += 7
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
    columns = get_columns
    return true if four_in_a_row?(columns)

    rows = get_rows
    return true if four_in_a_row?(rows)

    diagonals = get_diagonals(rows)
    return true if four_in_a_row?(diagonals)

    antediagonals = get_antediagonals(rows)
    return true if four_in_a_row?(antediagonals)

    false
  end

  def four_in_a_row?(array)
    array.each do |sub|
      cons_array = sub.each_cons(4).find { |arr| arr.uniq.size == 1 }
      return true unless cons_array.nil?
    end
    false
  end

  def get_columns
    grid.map do |column, array|
      array
    end
  end

  def get_rows
    rows = []
    6.times do |i|
      row = []
      grid.each do |_, array|
        row << array[i]
      end
      rows << row
    end
    rows
  end

  def get_diagonals(row_array)
    (0..row_array.size - 4).map do |i|
      (0..row_array.size - 1 - i).map do |j|
        row_array[i + j][j]
      end
    end.concat((1..row_array.first.size - 4).map do |x|
      (0..row_array.size - x).map do |y|
        row_array[y][x + y]
      end
    end)
  end

  def get_antediagonals(row_array)
    0.upto(2).map do |i|
      6.downto(i + 1).map do |j|
        row_array[(j - (row_array.size)).abs + i][j]
      end
    end.concat((5.downto(3)).map do |x|
      (0.upto(x)).map do |y|
        row_array[y][x - y]
      end
    end)
  end

  def rotate90(array)
    col_num = array.first.size - 1
    array.each_index.with_object([]) do |i, a|
      a << col_num.times.map { |j| array[j][col_num - i] }
    end
  end

  #   diagonals = []
  #   column = 1
  #   element = 0
  #   loop do
  #     diagonal = []
  #     loop do
  #       inner_column_counter = column
  #       inner_element_counter = element
  #       diagonal << grid[inner_column_counter][inner_element_counter] if diagonal.empty?
  #       unless inner_element_counter == 0
  #         diagonal << grid[inner_column_counter + 1][inner_element_counter - 1]
  #         inner_column_counter += 1
  #         inner_element_counter -= 1
  #       end
  #       break if element == 6
  #       element += 1
  #     end
  #     diagonals << diagonal
  #     break if column == 7
  #     column += 1
  #   end
  # end

  def add_piece(column, symbol) #todo: extract position finding ?
    position = grid[column].inject { |memo, space| memo > space.to_i ? memo : space }
    available_index = grid[column].index(position)
    grid[column][available_index] = symbol
  end
end

board = Board.new
# p board.get_diagonals
board.display_board
