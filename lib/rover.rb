require_relative './rover/runner'

module Rover
  def self.play
    Runner.run
  end
end
