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
      @obstacles = []
    end

    # Calls create_board method and constructs Board
    def create_new_board(size)
      @rendered_board = @board.create_board(size)
    end

    # Updates the current position and direction of Robot
    def update_robot_position(new_x_position, new_y_position, new_direction)
      @rendered_robot[:position] = @robot.assign_position(new_x_position, new_y_position)
      @rendered_robot[:direction] = @robot.assign_direction(new_direction)
      @rendered_robot
    end

    # Checks if input position are of a negative value
    def negative_input(position_x, position_y)
      position_x.negative? == false && position_y.negative? == false
    end

    # Checks if input position is within Board limits
    def valid_tile(position_x, position_y)
      begin
        (@rendered_board[position_x][position_y].include?('X') == true ||
        @rendered_board[position_x][position_y].include?('R') == true)
      rescue StandardError
        puts 'Inputed coordinates are not within board limits.'
      end
    end

    # Checks if above validations are valid or invalid
    def valid_placement(new_x_position, new_y_position, new_direction)
      @position_x = new_x_position
      @position_y = new_y_position
      begin
        if negative_input(@position_x, @position_y) == true && valid_tile(@position_x, @position_y) == true && !check_obstacles(@position_x, @position_y)
          update_robot_position(new_x_position, new_y_position, new_direction)
          @robot_placed = true
        else
          puts 'ABORT COMMAND -- Action would cuase Robot to fall off the board. -- Please Try Again'
        end
      rescue StandardError
        puts 'Invalid Command -- Please Try Again'
      end
    end

    # If valid checks and moves Robot based on current direction
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

    # If move is invalid, reverts robot to prev position
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

    def create_obstacle(position_x, position_y)
      begin
        if !@obstacles.include?([position_x, position_y] && negative_input(position_x, position_y))
          @obstacles.push([position_x, position_y])
          @board.place_obstacle(position_x, position_y)
        end
      rescue StandardError
        puts 'Try Again'
      end
    end

    def check_obstacles(position_x, position_y)
      current_position = [position_x, position_y]
      @obstacles.include?(current_position)
    end

    def set_obstacle(position_x, position_y)
      @rendered_board[position_x][position_y]
    end

    # Checks if the Robot is on the Board
    def check_move
      begin
        if valid_placement(@rendered_robot[:position][0], @rendered_robot[:position][1], @rendered_robot[:direction]) == true
          @rendered_robot
        else
          revert_robot
        end
      rescue StandardError
        puts 'Robot has not been placed on Board -- Please try PLACE command first.'
      end
    end

    # If valid checks and turns Robot to the left based on current direction
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

    # If valid checks and turns Robot to the right based on current direction
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

    def find_path(path_position_x, path_position_y)
      begin
        current_position = @rendered_robot[:position]
        target_position = [path_position_x, path_position_y]
        if !@rendered_board.include?(target_position[0][1])
          find_optimised_path(@rendered_board, current_position, target_position, @obstacles)
        else
          puts 'Try Again'
        end
      rescue StandardError
        puts 'Robot has not been placed on Board -- Please try PLACE command first.'
      end
    end

    def find_adjacent_tiles_to_current_position(board, current_position, obstacles)
      current_pos_x = current_position[0]
      current_pos_y = current_position[1]
      all_current_adjacent_tiles = [[current_pos_x - 1, current_pos_y], [current_pos_x, current_pos_y + 1],
                                    [current_pos_x + 1, current_pos_y], [current_pos_x, current_pos_y - 1]]
      all_current_adjacent_tiles.select { |tile| tile[0].between?(0, board.size - 1) && tile[1].between?(0, board.first.size - 1) && !@obstacles.include?(tile)}
    end

    def possible_paths( board, current_position, target_position, current_path_taken, possible_path_list, obstacles)
      if current_position == target_position
        current_path_taken.push([current_position[0], current_position[1]])
        possible_path_list.push(current_path_taken)
      else
        find_adjacent_tiles_to_current_position(board, current_position, obstacles).each do |adjacent_position|
          if !current_path_taken.include?([current_position[0], current_position[1]])
            next_possible_path = current_path_taken.clone.push([current_position[0], current_position[1]])
            possible_paths(board, adjacent_position, target_position, next_possible_path, possible_path_list, obstacles)
          end
        end
      end
    end

    def find_optimised_path(board, current_position, target_position, obstacles)
      possible_path_list = []
      current_path_taken = []
      possible_paths(board, current_position, target_position, current_path_taken, possible_path_list, obstacles)
      if possible_path_list.empty? && !board.include?(target_position) && negative_input(target_position[0], target_position[1])
        puts 'Path could not be found'
      else
        current_optimised_path = possible_path_list.sort_by(&:size).first
        puts "Path: #{current_optimised_path}"
      end
    end

    # If Robot is on the Board, prints curnrent location annd direction of Robot and prints current state of the board
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
