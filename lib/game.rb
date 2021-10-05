# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/board'

class Game
  attr_accessor :player_1, :player_2, :board

  def initialize
    @player_1 = Player.new(currently_playing: true)
    @player_2 = Player.new
    @board = Board.new
  end

  def play_game
    gameplay_turn until game_over?
    display_end_of_game #todo: implement
    play_again?
  end

  def gameplay_turn
    board.display_board # todo: implement method
    player = get_current_player
    move = player.get_move
    board.add_piece(move, player.symbol)
    swap_players
  end

  def play_again?
    loop do
      puts 'would you like to play again?'
      answer = gets.chomp
      return true if ['y', 'yes'].include?(answer.downcase)
      return false if ['n', 'no'].include?(answer.downcase)
      puts 'invalid input: yes, y, no, n only'
    end
  end

  private

  def game_over?
    return true if winner? || board.board_full?
    false
  end

  def display_end_of_game; end

  def winner?; end

  def get_current_player
    for player in [player_1, player_2]
      return player if player.currently_playing
    end
  end

  def swap_players
    if player_1.currently_playing
      player_1.currently_playing = false
      player_2.currently_playing = true
    else
      player_2.currently_playing = false
      player_1.currently_playing = true
    end
  end
end
