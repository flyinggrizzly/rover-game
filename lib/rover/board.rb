module Rover
  class Board
    # Using a factory method since it should be very easy to extend this to
    # work for boards of any size, and the rest of the code could remain
    # unchanged if this signature were updated to accept x and y params, with
    # default values of 5
    def self.prepare
      new
    end

    def in_bounds?(address)
      proposed_x, proposed_y = address

      x_valid = proposed_x >= 0 && proposed_x < 5
      y_valid = proposed_y >= 0 && proposed_y < 5

      x_valid && y_valid
    end
  end
end
