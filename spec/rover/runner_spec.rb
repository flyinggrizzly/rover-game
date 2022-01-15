require 'rover/runner'

RSpec.describe Rover::Runner do
  describe '#wait_for_command' do
    let(:runner) { described_class.new  }

    it 'parses simple command input' do
      expect(runner).to receive(:gets_user_input) { 'MOVE' }

      expect(runner.wait_for_command).to eq(['MOVE', []])
    end

    it 'parses valid placement input' do
      expect(runner).to receive(:gets_user_input) { 'PLACE 0,1,NORTH' }

      expect(runner.wait_for_command).to eq(['PLACE', ['0', '1', 'NORTH']])
    end
  end
end
