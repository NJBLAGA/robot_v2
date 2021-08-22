# frozen_string_literal: true

module RobotV2
  class Prompt
    attr_accessor :prompt

    def initialize
    end

    def title_screen
      puts '*-' * 50
      puts 'Toy Robot Challenge -- Version 2.0'
      puts '*-' * 50
    end

    def exit_screen
      system('exit')
      puts ' '
      puts '*-' * 50
      puts 'Thank you for playing -- Goodebye'
      puts '*-' * 50
    end

    def mode
      puts "\n\sWould you like to play in:"
      puts ''
      puts "\sManual Mode  -- Type 1"
      puts "\sAuto Mode    -- Type 2"
      puts "\sExit Game    -- Type 3"
    end

    def auto_mode
      print 'Enter a Test file:'
      test_file = gets.chomp
      while !File.exists?(test_file)
        puts 'INVALID FILE -- Please check the spelling or existance of selected test-file.'
        test_file = gets.chomp
      end
      test_file
    end

    def command_selection
      puts "\n\sSelect one of the following commands:"
      puts "\n\sPLACE  -- Example -> PLACE 2,2,NORTH"
      puts "\sMOVE"
      puts "\sLEFT"
      puts "\sRIGHT"
      puts "\sREPORT"
      puts "\sEXIT GAME"
      puts "\nYour Command:"
    end
  end
end
