# frozen_string_literal: true

module RobotV2
  class Game
    attr_accessor :propmt, :commands

    def initialize
      @new_prompt = RobotV2::Prompt.new
      @new_commands = RobotV2::Commands.new
      @player_command = ''
      @player_move = ''
      @position_x = 0
      @position_y = 0
      @direction = ''
      @mode = ''
    end

    def start_game
      @new_prompt.title_screen
      @new_commands.create_new_board(5)
      select_mode
    end

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

    def handle_commands(player_inputs)
      filter_place_command(player_inputs)
      case @player_move 
      when 'PLACE'
        @new_commands.valid_placement(@position_x, @position_y, @direction)
      when 'MOVE'
        @new_commands.move_robot
      when 'LEFT'
        @new_commands.turn_left
      when 'RIGHT'
        @new_commands.turn_right
      when 'REPORT'
        @new_commands.report_position
      else
        puts 'INVALID COMMAND -- Plase select a valid command:'
      end
    end
  end
end
