# frozen_string_literal: true

module RobotV2

  class Game
    attr_accessor :commands

    def initialize
      @directions = ['NORTH', 'EAST', 'SOUTH', 'WEST']
    end
  end
end
