require_relative '../lib/game.rb'
require_relative '../lib/board.rb'
require_relative '../lib/player.rb'
require_relative '../lib/connect_four.rb'

describe Game do
  describe '#initialize' do
    it 'creates two players' do
      expect(Player).to receive(:new).twice
      game = described_class.new
    end

    it 'creates a board' do
      expect(Board).to receive(:new).once
      game = described_class.new
    end
  end

  describe '#play_game' do
    let(:round_game) { described_class.new }
    # context 'when the round starts' do

    # end

    context 'when the game is over' do
      it 'stops game loop' do
        allow(round_game).to receive(:game_over?).and_return(false, false, false, true)
        allow(round_game).to receive(:play_again?).and_return(false)
        expect(round_game).to receive(:gameplay_turn).exactly(3).times
        round_game.play_game
      end
    end
  end

  describe '#gameplay_turn' do
    let(:game_turn) { described_class.new }
    it 'displays the board' do
      allow(game_turn.player_1).to receive(:get_move)
      allow(game_turn.board).to receive(:add_piece)
      expect(game_turn.board).to receive(:display_board).once
      game_turn.gameplay_turn
    end

    it 'gets input from current player' do
      allow(game_turn.board).to receive(:add_piece)
      game_turn.player_1.currently_playing = true
      expect(game_turn.player_1).to receive(:get_move)
      game_turn.gameplay_turn
    end

    it 'adds piece to board' do
      allow(game_turn.player_1).to receive(:get_move)
      expect(game_turn.board).to receive(:add_piece)
      game_turn.gameplay_turn
    end

    it 'swaps the current player' do
      allow(game_turn.player_1).to receive(:get_move)
      allow(game_turn.board).to receive(:add_piece)
      game_turn.player_1.currently_playing = true
      game_turn.gameplay_turn
      expect(game_turn.player_2.currently_playing).to eql(true)
    end
  end

  # describe '#game_over?' do
  #   let(:end_game) { described_class.new }
  #   context 'when a player gets 4 in a row' do
  #     it 'returns true' do
  #       allow(end_game).to receive(:winner?).and_return(true)
  #       expect(end_game.game_over?).to eql(true)
  #     end
  #   end

  #   context 'when the board is full' do
  #     it 'returns true' do
  #       allow(end_game).to receive(:winner?).and_return(false)
  #       allow(end_game.board).to receive(:board_full?).and_return(true)
  #       expect(end_game.game_over?).to eql(true)
  #     end
  #   end

  #   context 'when there is no winner or full board' do
  #     it 'returns false' do
  #       allow(end_game).to receive(:winner?).and_return(false)
  #       allow(end_game.board).to receive(:board_full?).and_return(false)
  #       expect(end_game.game_over?).to eql(false)
  #     end
  #   end
  # end

  describe '#play_again?' do
    let(:again_game) { described_class.new }
    context 'when player enters a valid input' do
      before do
        allow(again_game).to receive(:puts)
      end
      it 'stops the input loop' do
        error_message = 'invalid input: yes, y, no, n only'
        allow(again_game).to receive(:gets).and_return('yes')
        expect(again_game).not_to receive(:puts).with(error_message)
        again_game.play_again?
      end
      context 'when that input is yes' do
        it 'returns true' do
          valid_input = 'yes'
          allow(again_game).to receive(:gets).and_return(valid_input)
          expect(again_game.play_again?).to eql(true)
        end
      end

      context 'when that input is no' do
        it 'returns false' do
          valid_input = 'no'
          allow(again_game).to receive(:gets).and_return(valid_input)
          expect(again_game.play_again?).to eql(false)
        end
      end
    end

    context 'when player enters an invalid input' do
      it 'displays error message' do
        error_message = 'invalid input: yes, y, no, n only'
        invalid_input = 'norp'
        valid_input = 'y'
        allow(again_game).to receive(:gets).and_return(invalid_input, valid_input)
        allow(again_game).to receive(:puts).with('would you like to play again?')
        expect(again_game).to receive(:puts).with(error_message).once
        again_game.play_again?
      end
    end
  end

  # describe '#swap_players' do
  #   context 'when current player is player 1' do
  #     xit 'swaps current player to player 2' do
  #       expect { game_turn.swap_players }.to change { game_turn.player_1.currently_playing }.from(true).to(false)
  #     end
  #   end

  #   context 'when current player is player 2' do
  #     xit 'swaps current player to player 1' do
  #       game_turn.player_1 = Player.new(currently_playing: false)
  #       game_turn.player_2 = Player.new(currently_playing: true)
  #       expect { game_turn.swap_players }.to change { game_turn.player_2.currently_playing }.from(true).to(false)
  #     end
  #   end
  # end

  describe '#winner?' do
    let(:win_game) { described_class.new }
    context 'when there are 4 of the same symbol in a row' do
      it "returns true when they're all in the same column" do
        win_column = [1, 2, 'x', 'x', 'x', 'x']
        win_game.board.grid[1] = win_column
        expect(win_game.winner?).to eql(true)
      end

      xit "returns true when they're all in the same row" do
      end

      xit "returns true when they're diagonal" do
      end
    end

    context 'When there are not 4 in a row' do
      xit 'returns false' do
      end
    end
  end
end

describe Player do
  describe '#get_move' do
    let(:move_player) { described_class.new }
    let(:error_message) { 'Invalid input: please enter a column number' }
    before do
      allow(move_player).to receive(:puts)
    end
    context 'when player enters a valid input' do
      it 'breaks the loop' do
        valid_input = rand(1..7).to_s
        allow(move_player).to receive(:gets).and_return(valid_input)
        expect(move_player).not_to receive(:puts).with(error_message)
        move_player.get_move
      end
    end

    context 'when player enters an invalid input' do
      it 'displays an error message' do
        invalid_1 = '8'
        invalid_2 = '0'
        invalid_3 = 'x'
        valid = rand(1..7).to_s
        allow(move_player).to receive(:gets).and_return(invalid_1, invalid_2, invalid_3, valid)
        expect(move_player).to receive(:puts).with(error_message).exactly(3).times
        move_player.get_move
      end
    end
  end
end

describe Board do
  describe '#add_piece' do
    let(:adding_board) { described_class.new }
    let(:input) { rand(1..7) }
    let(:symbol) { 'x' }
    let(:move) { lambda { adding_board.add_piece(input, symbol) } }
    context 'when the column has no pieces in it ' do
      it 'changes the bottom value to the players symbol' do
        expect { move.call }.to change { adding_board.grid[input].last }.from(6).to('x')
      end
    end
    context 'when the column already has pieces in it' do
      it 'adds the new piece on top' do
        adding_board.grid[input] = [1, 2, 3, 4, 5, 'x']
        expect { move.call }.to change { adding_board.grid[input][-2] }.from(5).to('x')
      end
    end
  end

  describe '#board_full' do
    let(:full_board) { described_class.new }
    it 'returns true when full' do
      full_column = %w(x x x x x x)
      for i in (1..7)
        full_board.grid[i] = full_column
      end
      expect(full_board.board_full?).to eql(true)
    end

    it 'returns false when not full' do
      expect(full_board.board_full?).to eql(false)
    end
  end
end
