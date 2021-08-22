# frozen_string_literal: true

module RobotV2
  class Robot
    attr_accessor :robot

    def initialize
      @robot = {
        position: [nil, nil],
        direction: ''
      }
    end

    # Assigns positon of Robot
    def assign_position(new_x_position, new_y_position)
      @robot[:position] = [new_x_position, new_y_position]
    end

    # Assigns direction of Robot
    def assign_direction(new_direction)
      @robot[:direction] = new_direction
    end

    # Checks if robots position is of nil value
    def robot_on_board
      !@robot[:position][0].nil?
    end

    # Prints the current position and direction of Robot
    def robot_report
      if robot_on_board
        puts "Output: Robot's Current Position at: #{@robot[:position]} Facing: #{@robot[:direction]}."
      end
    end
  end
end
