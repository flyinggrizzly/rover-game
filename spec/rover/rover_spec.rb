require 'rover/rover'
require 'rover/board'

RSpec.describe Rover::Rover do
  let(:board) { Rover::Board.prepare }
  let(:rover) { described_class.new(board) }

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
