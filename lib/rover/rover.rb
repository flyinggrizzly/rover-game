module Rover
  class Rover
    attr_accessor :x, :y, :facing

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

    def place(new_x, new_y, new_facing)
      raise "Invalid address [#{new_x}, #{new_y}]" unless board.in_bounds?([new_x, new_y])
      raise "Invalid facing #{new_facing}" unless FACINGS.include?(new_facing)

      @x = new_x
      @y = new_y
      @facing = new_facing

      self
    end

    private

    attr_accessor :board

  end
end
