require_relative('../lib/game.rb')

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
end
