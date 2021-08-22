# frozen_string_literal: true

module RobotV2
  class Commands
    attr_accessor :board, :robot

    def initialize
      @board = RobotV2::Board.new
      @robot = RobotV2::Robot.new
      @rendered_robot = {}
      @rendered_board = nil
      @robot_placed = false
    end

    def create_new_board(size)
      @rendered_board = @board.create_board(size)
    end

    def update_robot_position(new_x_position, new_y_position, new_direction)
      @rendered_robot[:position] = @robot.assign_position(new_x_position, new_y_position)
      @rendered_robot[:direction] = @robot.assign_direction(new_direction)
      @rendered_robot
    end

    def negative_input(position_x, position_y)
      position_x.negative? == false && position_y.negative? == false
    end

    def valid_tile(position_x, position_y)
      begin
        (@rendered_board[position_x][position_y].include?('X') == true ||
        @rendered_board[position_x][position_y].include?('R') == true)
      rescue
        puts 'Inputed coordinates are not within board limits.'
      end
    end

    def valid_placement(new_x_position, new_y_position, new_direction)
      @position_x = new_x_position
      @position_y = new_y_position
      begin
        if negative_input(@position_x, @position_y) == true && valid_tile(@position_x, @position_y) == true
          update_robot_position(new_x_position, new_y_position, new_direction)
          @robot_placed = true
        else
          puts 'ABORT COMMAND -- Action would cuase Robot to fall off the board. -- Please Try Again'
        end
      rescue 
        puts 'Invalid Command -- Please Try Again'
      end
    end

    def move_robot
      case @rendered_robot[:direction]
      when 'NORTH'
        @rendered_robot[:position][0] += 1
      when 'EAST'
        @rendered_robot[:position][1] += 1
      when 'SOUTH'
        @rendered_robot[:position][0] -= 1
      when 'WEST'
        @rendered_robot[:position][1] -= 1
      end
      check_move
    end

    def revert_robot
      case @rendered_robot[:direction]
      when 'NORTH'
        @rendered_robot[:position][0] -= 1
      when 'EAST'
        @rendered_robot[:position][1] -= 1
      when 'SOUTH'
        @rendered_robot[:position][0] += 1
      when 'WEST'
        @rendered_robot[:position][1] += 1
      end
      @rendered_robot
    end

    def check_move
      begin
      if valid_placement(@rendered_robot[:position][0], @rendered_robot[:position][1], @rendered_robot[:direction]) == true
      return @rendered_robot
      else
        revert_robot
      end
      rescue
        puts 'Robot has not been placed on Board -- Please try PLACE command first.'
      end
    end

    def turn_left
      begin
        case @rendered_robot[:direction]
        when 'NORTH'
          @rendered_robot[:direction] = 'WEST'
        when 'EAST'
          @rendered_robot[:direction] = 'NORTH'
        when 'SOUTH'
          @rendered_robot[:direction] = 'EAST'
        when 'WEST'
          @rendered_robot[:direction] = 'SOUTH'
        end
        update_robot_position(@rendered_robot[:position][0], @rendered_robot[:position][1], @rendered_robot[:direction])
      rescue StandardError
        puts 'Robot has not been placed on Board -- Please try PLACE command first.'
      end
    end

    def turn_right
      begin
        case @rendered_robot[:direction]
        when 'NORTH'
          @rendered_robot[:direction] = 'EAST'
        when 'EAST'
          @rendered_robot[:direction] = 'SOUTH'
        when 'SOUTH'
          @rendered_robot[:direction] = 'WEST'
        when 'WEST'
          @rendered_robot[:direction] = 'NORTH'
        end
        update_robot_position(@rendered_robot[:position][0], @rendered_robot[:position][1], @rendered_robot[:direction])
      rescue StandardError
        puts 'Robot has not been placed on Board -- Please try PLACE command first.'
      end
    end

    def report_position
      if @robot_placed == true
        @board.display_board(@rendered_robot[:position][0], @rendered_robot[:position][1])
        @robot.robot_report
        @robot_placed
      else
        @board.display_board(nil, nil)
        puts 'Robot has not been placed on the Board.'
      end
    end
  end
end
