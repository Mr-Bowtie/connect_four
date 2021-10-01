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
        expect(round_game).to receive(:gameplay_turn).exactly(3).times
        round_game.play_game
      end
    end
  end

  describe '#gameplay_turn' do
    let(:game_turn) { described_class.new }
    it 'displays the board' do
      expect(game_turn.board).to receive(:display_board).once
      game_turn.gameplay_turn
    end

    it 'gets input from current player' do
      expect(game_turn.get_current_player).to receive(:get_move)
      game_turn.gameplay_turn
    end

    it 'adds piece to board' do
      expect(game_turn.board).to receive(:add_piece)
      game_turn.gameplay_turn
    end

    it 'swaps the current player' do
      expect(game_turn).to receive(:swap_players)
      game_turn.gameplay_turn
    end
  end

  describe '#game_over?' do
    let(:end_game) { described_class.new }
    context 'when a player gets 4 in a row' do
      it 'returns true' do
        allow(end_game).to receive(:winner?).and_return(true)
        expect(end_game.game_over?).to eql(true)
      end
    end

    context 'when the board is full' do
      it 'returns true' do
        allow(end_game).to receive(:winner?).and_return(false)
        allow(end_game.board).to receive(:board_full?).and_return(true)
        expect(end_game.game_over?).to eql(true)
      end
    end

    context 'when there is no winner or full board' do
      it 'returns false' do
        allow(end_game).to receive(:winner?).and_return(false)
        allow(end_game.board).to receive(:board_full?).and_return(false)
        expect(end_game.game_over?).to eql(false)
      end
    end
  end

  describe '#play_again?' do
    let(:again_game) { described_class.new }
    context 'when player enters a valid input' do
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
        xit 'returns false' do
        end
      end
    end
  end

  describe '#swap_players' do
    context 'when current player is player 1' do
      xit 'swaps current player to player 2' do
        expect { game_turn.swap_players }.to change { game_turn.player_1.currently_playing }.from(true).to(false)
      end
    end

    context 'when current player is player 2' do
      xit 'swaps current player to player 1' do
        game_turn.player_1 = Player.new(currently_playing: false)
        game_turn.player_2 = Player.new(currently_playing: true)
        expect { game_turn.swap_players }.to change { game_turn.player_2.currently_playing }.from(true).to(false)
      end
    end
  end
end
