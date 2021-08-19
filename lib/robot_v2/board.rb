# frozen_string_literal: true

module RobotV2
  class Board
    attr_accessor :board

    def initialization
      @table = []
      @prev_position_x = 0
      @prev_position_y = 0
    end

    def create_board(size)
      @table = Array.new(size) { Array.new(size, 'X') }
    end

    def draw_board
      puts "\n"
      puts @table.reverse.map { |x| x.join(' ') }
      puts "\n"
    end

    def update_last_position
      @table[@prev_position_x.to_i][@prev_position_y.to_i] = 'X'
    end

    def place_robot(position_x, position_y)
      @table[position_x][position_y] = 'R'
      @prev_position_x = position_x
      @prev_position_y = position_y
    end

    def display_board(position_x, position_y)
      update_last_position
      place_robot(position_x, position_y)
      draw_board
    end
  end
end
