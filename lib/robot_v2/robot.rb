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

    def assign_position(new_x_position, new_y_position)
      @robot[:position] = [new_x_position, new_y_position]
    end

    def assign_direction(new_direction)
      @robot[:direction] = new_direction
    end

    def robot_on_board
      !@robot[:position][0].nil?
    end

    def robot_report
      if robot_on_board
        puts "Output: Robot's Current Position at: #{@robot[:position]} Facing: #{@robot[:direction]}."
      else
        puts 'Robot has not been placed on the board'
      end
    end
  end
end
