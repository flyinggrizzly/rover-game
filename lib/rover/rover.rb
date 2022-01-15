module Rover
  class Rover
    attr_reader :x, :y, :facing

    NORTH = 'NORTH'.freeze
    EAST = 'EAST'.freeze
    SOUTH = 'SOUTH'.freeze
    WEST = 'WEST'.freeze
    FACINGS = [NORTH, EAST, SOUTH, WEST].freeze

    LEFT = 'LEFT'.freeze
    RIGHT = 'RIGHT'.freeze

    def initialize(board)
      @board = board
      @x = nil
      @y = nil
      @facing = nil
    end

    def move!
      return self unless board.in_bounds?(address_for_move)

      @x = address_for_move[0]
      @y = address_for_move[1]

      self
    end

    def place(new_x, new_y, new_facing)
      raise "Invalid address [#{new_x}, #{new_y}]" unless board.in_bounds?([new_x, new_y])
      raise "Invalid facing #{new_facing}" unless FACINGS.include?(new_facing)

      @x = new_x
      @y = new_y
      @facing = new_facing

      self
    end

    private

    attr_reader :board

    def address_for_move
      case facing
      when NORTH
        [x, y + 1]
      when EAST
        [x + 1, y]
      when SOUTH
        [x, y - 1]
      when WEST
        [x - 1, y]
      else
        raise "Cannot create new address for unknown facing #{facing}"
      end
    end
  end
end
