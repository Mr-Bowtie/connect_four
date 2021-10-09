# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/board'
require_relative '../lib/characters.rb'

class Game
  include Characters
  attr_accessor :player_1, :player_2, :board

  def initialize
    @player_1 = Player.new(red_token, currently_playing: true)
    @player_2 = Player.new(yellow_token)
    @board = Board.new
  end

  def play_game
    display_welcome
    get_player_names
    loop do
      gameplay_turn
      break if game_over?
      swap_players
    end
    display_end_of_game
  end

  def gameplay_turn
    player = get_current_player
    board.display_board
    turn_display = "#{player.symbol}  #{player.name}'s turn  #{player.symbol}".center(45)
    puts turn_display
    move = player.get_move
    board.add_piece(move, player.symbol)
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

  def game_over?
    return true if board.winner? || board.board_full?
    false
  end

  def display_welcome
    system('clear')
    puts 'Welcome to Connect Four'
    puts "#{red_token}#{yellow_token}" * 12
    puts 'press enter to start game'
    gets
  end

  def display_end_of_game
    board.display_board
    if board.winner?
      puts "#{get_current_player.name} wins! "
    elsif board.board_full?
      puts 'No moves left: Game Over'
    end
  end

  def get_player_names
    puts 'Enter name for player 1'
    self.player_1.name = gets.chomp
    puts ''
    puts 'Enter name for player 2'
    self.player_2.name = gets.chomp
  end

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
