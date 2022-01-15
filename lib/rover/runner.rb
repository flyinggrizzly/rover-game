require_relative './board'
require_relative './rover'

module Rover
  class Runner
    attr_reader :board, :rover

    def self.run
      runner = new

      while true do
        command = gets.chomp
        command_elements = command.split(' ')
        instruction = command_elements.first

        case instruction
        when 'PLACE'
          arguments = command_elements[1].split(',')

          runner.place(arguments)
        when 'MOVE'
          runner.move
        when 'LEFT'
          runner.left
        when 'RIGHT'
          runner.right
        when 'REPORT'
          runner.report
        end
      end
    end

    def initialize
      @board = Board.prepare
      @rover = Rover.new(board)
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
  end
end
