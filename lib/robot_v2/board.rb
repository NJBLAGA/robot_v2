# frozen_string_literal: true

module RobotV2
  class Board
    attr_accessor :board

    def initialize
      @board = []
      @prev_position_x = 0
      @prev_position_y = 0
    end

    # Creates a 2D array/matrix based on arg of size
    def create_board(size)
      @board = Array.new(size) { Array.new(size, 'X') }
    end

    # Prints to the screen and display of the board
    def draw_board
      puts "\n"
      puts @board.reverse.map { |x| x.join(' ') }
      puts "\n"
    end

    # Finds the last position the Robot as X
    def update_last_position
      @board[@prev_position_x.to_i][@prev_position_y.to_i] = 'X'
    end

    # Denotes the current position of the Robot with R
    def place_robot(position_x, position_y)
      @prev_position_x = position_x
      @prev_position_y = position_y
      @board[position_x][position_y] = 'R'
    end

    def place_obstacle(position_x, position_y)
      @board[position_x][position_y] = 'O'
    end

    # Displays the Board and current postion of Robot if conditions are met
    def display_board(position_x, position_y)
      if position_x.nil? || position_y.nil?
      else
        update_last_position
        place_robot(position_x, position_y)
      end
      draw_board
    end
  end
end
