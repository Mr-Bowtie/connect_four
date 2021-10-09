require_relative('../lib/board.rb')

describe Board do
  describe '#add_piece' do
    let(:adding_board) { described_class.new }
    let(:input) { rand(1..7) }
    let(:symbol) { 'x' }
    let(:move) { lambda { adding_board.add_piece(input, symbol) } }
    context 'when the column has no pieces in it ' do
      it 'changes the bottom value to the players symbol' do
        expect { move.call }.to change { adding_board.grid[input].last }.to('x')
      end
    end
    context 'when the column already has pieces in it' do
      it 'adds the new piece on top' do
        adding_board.grid[input] = [1, 2, 3, 4, 5, 'x']
        expect { move.call }.to change { adding_board.grid[input][-2] }.from(5).to('x')
      end
    end
  end

  describe '#winner?' do
    let(:win_board) { described_class.new }
    context 'When there are 4 consecutive player tokens on the board' do
      it "returns true when they're all in the same column" do
        4.times { win_board.add_piece(1, 'x') }
        expect(win_board.winner?).to eql(true)
      end

      it "returns true when they're all in the same row" do
        win_board.add_piece(1, 'x')
        win_board.add_piece(2, 'x')
        win_board.add_piece(3, 'x')
        win_board.add_piece(4, 'x')
        expect(win_board.winner?).to eql(true)
      end

      it "returns true when they're diagonal" do
        win_board.add_piece(1, 'x')
        win_board.add_piece(2, 'o')
        win_board.add_piece(2, 'x')
        win_board.add_piece(3, 'o')
        win_board.add_piece(3, 'o')
        win_board.add_piece(3, 'x')
        win_board.add_piece(4, 'o')
        win_board.add_piece(4, 'o')
        win_board.add_piece(4, 'o')
        win_board.add_piece(4, 'x')
        expect(win_board.winner?).to eql(true)
      end
    end

    context 'When there are not 4 in a row' do
      it 'returns false' do
        expect(win_board.winner?).to eql(false)
      end
    end
  end

  describe '#four_in_a_row?' do
    let(:column_board) { described_class.new }
    context 'when there are 4 of the same tokens connected in a column' do
      it 'returns true with only one players symbols' do
        winning_column = ['x', 'x', 'x', 'x', 5, 6]
        winning_board = Array.new(5) { Array.new } << winning_column
        result = column_board.four_in_a_row?(winning_board)
        expect(result).to eql(true)
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
