require 'rover/rover'
require 'rover/board'

RSpec.describe Rover::Rover do
  let(:board) { Rover::Board.prepare }
  let(:rover) { described_class.new(board) }
  let(:x) { 0 }
  let(:y) { 0 }
  let(:facing) { described_class::NORTH }

  subject { rover.place(x, y, facing) }

  describe '#turn!' do
    it 'cannot be called before #place' do
      expect{
        rover.turn!(described_class::LEFT)
      }.to raise_error(described_class::UnplacedRoverError)
    end

    it 'updates the facing' do
      cases = [
        # Looping around the back of the directions array
        [described_class::NORTH, described_class::LEFT, described_class::WEST],
        [described_class::WEST, described_class::RIGHT, described_class::NORTH],

        # Normal operation
        [described_class::NORTH, described_class::RIGHT, described_class::EAST],
      ]

      cases.each do |(starting, turn_dir, ending)|
        placed = rover.place(0, 0, starting)
        turned = placed.turn!(turn_dir)

        expect(turned.facing).to eq(ending)
      end
    end

    describe 'with an invalid turn direction' do
      it do
        expect {
          subject.turn!('ABC')
        }.to raise_error("Cannot turn in unknown direction ABC")
      end
    end
  end

  describe '#move!' do
    it 'cannot be called before #place' do
      expect{
        rover.move!
      }.to raise_error(described_class::UnplacedRoverError)
    end

    describe 'for a legal move (that remains on the board)' do
      it 'returns a new rover with an updated address' do
        moved = subject.move!

        expect(moved.x).to eq(0)
        expect(moved.y).to eq(1)
        expect(moved.facing).to eq(described_class:: NORTH)
      end
    end

    describe 'for an illegal move (that would take the rover off the board)' do
      let(:x) { 4 }
      let(:y) { 4 }

      it 'raises an error' do
        moved = subject.move!

        expect(moved.x).to eq(4)
        expect(moved.y).to eq(4)
        expect(moved.facing).to eq(described_class:: NORTH)
      end
    end
  end

  describe '#place' do
    describe 'for a legal address' do
      it 'places itself' do
        placed = rover.place(1, 1, described_class::NORTH)

        expect(placed.x).to eq(1)
        expect(placed.y).to eq(1)
        expect(placed.facing).to eq('NORTH')
      end
    end

    describe 'with an invalid facing' do
      it do
        expect {
          rover.place(0, 0, 'ABC')
        }.to raise_error("Invalid facing ABC")
      end
    end

    describe 'with an out of bounds address' do
      it do
        expect {
          rover.place(-1, -1, described_class::NORTH)
        }.to raise_error("Invalid address [-1, -1]")
      end
    end
  end
end
