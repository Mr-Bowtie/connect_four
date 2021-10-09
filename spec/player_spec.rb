require_relative '../lib/player.rb'

describe Player do
  describe '#get_move' do
    let(:move_player) { described_class.new('x') }
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
