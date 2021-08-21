# frozen_string_literal: true

module RobotV2
  class Commands
    attr_accessor :board, :robot

    def initialize
      @board = RobotV2::Board.new
      @robot = RobotV2::Robot.new
      @rendered_robot = {}
      @rendered_board = nil
    end

    def create_new_board(size)
      @rendered_board = @board.create_board(size)
    end

    def update_robot_position(new_x_position, new_y_position, new_direction)
      @rendered_robot[:position] = @robot.assign_position(new_x_position, new_y_position)
      @rendered_robot[:direction] = @robot.assign_direction(new_direction)
    end

    def negative_input(position_x, position_y)
      position_x.negative? == false && position_y.negative? == false
    end

    def valid_tile(position_x, position_y)
      (@rendered_board[position_x][position_y].include?('X') == true ||
      @rendered_board[position_x][position_y].include?('R') == true)
    end

    def valid_placement
      position_x = @rendered_robot[:position][0].to_i
      position_y = @rendered_robot[:position][1].to_i
      begin
        if negative_input(position_x, position_y) == true && valid_tile(position_x, position_y) == true
          @robot.robot_report
        else
          puts "Invalid Input -- X & Y must be positive and exist within the board's dimensions -- Try Again"
        end
      rescue 
        puts "Inputs of #{@rendered_robot[:position]} are outside the board's dimensions -- Try Again"
      end
    end
  end
end
