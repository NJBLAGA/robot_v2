# frozen_string_literal: true

module RobotV2
  class Game
    attr_accessor :propmt, :commands

    def initialize
      @new_prompt = RobotV2::Prompt.new
      @new_commands = RobotV2::Commands.new
      @player_command = ''
      @obs_command = ''
      @path_command = ''
      @player_obs  = ''
      @player_move = ''
      @position_x = 0
      @position_y = 0
      @direction = ''
      @mode = ''
    end

    # Creates new instance of Board and calls Mode selection screen
    def start_game
      @new_prompt.title_screen
      @new_commands.create_new_board(5)
      select_mode
    end

    # Prompts User for Mode selection
    def select_mode
      @new_prompt.mode
      puts ''
      begin
        @mode = gets.chomp.upcase
        handle_mode
      rescue StandardError
        puts 'INVALID OPTION -- Please Try Again'
      end
    end

    # Handles player inputs and calls respective methods
    def handle_mode
      case @mode
      when '1'
        input_commands
      when '2'
        handle_auto
      when '3'
        @new_prompt.exit_screen
      end
    end

    # Opens selected file and reads each line within text file
    def handle_auto
      test_file = @new_prompt.auto_mode
      File.open(test_file, 'r') do |file|
        commands = file.readlines
        commands.each do |command|
          handle_commands(command)
          puts ' '
        end
      end
    end

    # Runs while loop to ensure the player continues to play in manual mode
    def input_commands
      @new_prompt.command_selection
      command = gets.chomp.upcase
      while command != 'EXIT GAME'
        @player_command = command
        handle_commands(@player_command)
        @new_prompt.command_selection
        command = gets.chomp.upcase
      end
      @new_prompt.exit_screen
    end

    # Runs regular expression to spilt place method
    def filter_place_command(player_inputs)
      begin
        if player_inputs.include? 'PLACE'
        @place_command = player_inputs.match(/^PLACE *([0-4]), *([0-4]),\s*(NORTH|SOUTH|EAST|WEST)$/i)
        @position_x = @place_command[1].to_i
        @position_y = @place_command[2].to_i
        @direction = @place_command[3]
        end
        @player_move = player_inputs.split(' ').first
      rescue StandardError
        puts 'The PLACE command must include valid x,y,f coordinates.'
      end
    end

    def filter_obstacles(player_inputs)
      begin
        if player_inputs.include? 'OBSTACLE'
          @obs_command = player_inputs.match(/^OBSTACLE *([0-4]), *([0-4])$/i)
          @obs_postion_x = @obs_command[1].to_i
          @obs_postion_y = @obs_command[2].to_i
        end
        @player_move = player_inputs.split(' ').first
      rescue StandardError
        puts 'The OBSTACLE command must include valid x,y coordinates.'
      end
    end

    def filter_path(player_inputs)
      begin
        if player_inputs.include? 'PATH'
          @path_command = player_inputs.match(/^PATH *([0-4]), *([0-4])$/i)
          @path_position_x = @path_command[1].to_i
          @path_position_y = @path_command[2].to_i
        end
        @player_move = player_inputs.split(' ').first
      rescue StandardError
        puts 'The PATH command must include valid x,y coordinates.'
      end
    end

    # Handles player inputs and returns respected methods
    def handle_commands(player_inputs)
      filter_place_command(player_inputs)
      filter_obstacles(player_inputs)
      filter_path(player_inputs)
      case @player_move
      when 'PLACE'
        @new_commands.valid_placement(@position_x, @position_y, @direction)
      when 'MOVE'
        @new_commands.move_robot
      when 'LEFT'
        @new_commands.turn_left
      when 'RIGHT'
        @new_commands.turn_right
      when 'OBSTACLE'
        @new_commands.create_obstacle(@obs_postion_x, @obs_postion_y)
        @new_commands.check_obstacles(@obs_postion_x, @obs_postion_y)
      when 'PATH'
        @new_commands.find_path(@path_position_x, @path_position_y)
      when 'REPORT'
        @new_commands.report_position
      else
        puts 'INVALID COMMAND -- Plase select a valid command:'
      end
    end
  end
end
