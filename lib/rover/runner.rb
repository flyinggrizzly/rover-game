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
      wait_for_placement_input until placed?

      while true do
        instruction, arguments = wait_for_command

        case instruction
        when 'PLACE'
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

    def wait_for_command
      input = gets_user_input.chomp

      elements = input.split(' ')

      instruction = elements.first

      # Casting the possibly non-existent arguments to a String allows us to handle the PLACE params
      arguments = String(elements[1]).split(',')

      [ instruction, arguments ]
    end

    private

    # Seam for testing without stubbing $stdin
    def gets_user_input
      gets
    end

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
      instruction, arguments = wait_for_command

      return unless instruction == 'PLACE'

      place(arguments)
    end
  end
end
