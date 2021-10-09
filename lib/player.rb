class Player
  attr_accessor :currently_playing, :symbol, :name

  def initialize(symbol, currently_playing: false, name: '')
    @symbol = symbol
    @name = name
    @currently_playing = currently_playing
  end

  def take_turn
  end

  def get_move
    column = ''
    loop do
      puts 'Enter column number'
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
