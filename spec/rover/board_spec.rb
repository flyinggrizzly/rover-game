require 'rover/board'

RSpec.describe Rover::Board do
  subject { described_class.prepare }

  describe '#in_bounds' do
    describe 'for a legal address' do
      it 'returns true' do
        expect(subject.in_bounds?([0, 0])).to eq(true)
      end
    end

    describe 'for illegal addresses' do
      let(:x) { 0 }
      let(:y) { 0 }
      let(:address) { [x, y] }

      describe 'for an address that is too far left (negative x)' do
        let(:x) { -1 }

        it 'returns false' do
          expect(subject.in_bounds?(address)).to eq(false)
        end
      end

      describe 'for an address that is too far right (x > 4)' do
        let(:x) { 5 }

        it 'returns false' do
          expect(subject.in_bounds?(address)).to eq(false)
        end
      end

      describe 'for an address that is too far down (negative y)' do
        let(:y) { -1 }

        it 'returns false' do
          expect(subject.in_bounds?(address)).to eq(false)
        end
      end

      describe 'for an address that is too far up (y > 4)' do
        let(:y) { 5 }

        it 'returns false' do
          expect(subject.in_bounds?(address)).to eq(false)
        end
      end
    end
  end
end
