class Player
  attr_accessor :currently_playing, :symbol

  def initialize(symbol, currently_playing: false)
    @symbol = symbol
    @currently_playing = currently_playing
  end

  def take_turn
  end

  def get_move
    column = ''
    loop do
      puts 'Please enter the column number you wish add to'
      column = gets.chomp.to_i
      break if valid_input?(column)
      puts 'Invalid input: please enter a column number'
    end
    column
  end

  private

  def valid_input?(input)
    (1..7).include?(input)
  end
end
