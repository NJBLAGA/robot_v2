# frozen_string_literal: true

module RobotV2

  class Prompt
    attr_accessor :prompt

    def initialize
      @directions = ['NORTH', 'EAST', 'SOUTH', 'WEST']
    end

    def title_screen
      puts '*-' * 50
      puts 'Toy Robot Challenge -- Version 2.0'
      puts '*-' * 50
    end

    def exit_screen
      puts '*-' * 50
      puts 'Thank you for playing -- Goodebye'
      puts '*-' * 50
    end

    def command_selection
      puts "\n\sSelect on of the following commands:"
      puts "\n\sPLACE  -- Example -> PLACE 2,2,NORTH"
      puts "\sMOVE"
      puts "\sLEFT"
      puts "\sRIGHT"
      puts "\sREPORT"
      puts "\sEXIT GAME"
      puts "\n\sYour Command:"
    end
  end
end
