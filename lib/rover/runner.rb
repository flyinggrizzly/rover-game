require_relative './board'
require_relative './rover'

module Rover
  class Runner
    attr_reader :board, :rover

    def self.run
      new.run
    end

    def initialize
      @board = Board.prepare
      @rover = Rover.new(board)
    end

    def run
      wait_for_placement_input
      wait_for_all_inputs
    end

    private

    def placed?
      rover.placed?
    end

    def place(arguments)
      x_address = arguments.first.to_i
      y_address = arguments[1].to_i
      facing = arguments[2]

      rover.place(x_address, y_address, facing)
    end

    def report
      address = rover.report

      puts address.join(',')
    end

    def left
      rover.left!
    end

    def right
      rover.right!
    end

    def move
      rover.move!
    end

    def wait_for_placement_input
      until placed?
        command = gets.chomp
        command_elements = command.split(' ')
        instruction = command_elements.first

        next unless instruction == 'PLACE'

        arguments = command_elements[1].split(',')

        place(arguments)
      end
    end

    def wait_for_all_inputs
      while true do
        command = gets.chomp
        command_elements = command.split(' ')
        instruction = command_elements.first

        case instruction
        when 'PLACE'
          arguments = command_elements[1].split(',')

          place(arguments)
        when 'MOVE'
          move
        when 'LEFT'
          left
        when 'RIGHT'
          right
        when 'REPORT'
          report
        end
      end
    end
  end
end
