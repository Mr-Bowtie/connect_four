class Player
  attr_accessor :currently_playing

  def initialize(currently_playing: false)
    @symbol = ''
    @currently_playing = currently_playing
  end

  def take_turn
  end

  def get_move; end
end
