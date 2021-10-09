require_relative './game.rb'

loop do
  connect_four = Game.new
  connect_four.play_game
  break unless connect_four.play_again?
end
