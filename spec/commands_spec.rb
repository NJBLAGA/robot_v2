require 'robot_v2/commands'

test_commands = RobotV2::Commands.new

RSpec.describe RobotV2::Commands do
  it 'Creates board based on arg size' do
    board25 = [['X', 'X', 'X', 'X', 'X'], ['X', 'X', 'X', 'X', 'X'], ['X', 'X', 'X', 'X', 'X'], ['X', 'X', 'X', 'X', 'X'], ['X', 'X', 'X', 'X', 'X']]
    expect(test_commands.create_new_board(5)).to eql(board25)
  end

  it 'Stores inputs within rendered_robot hash' do
    rendered_robot = { position: [2, 2], direction: 'NORTH' }
    expect(test_commands.update_robot_position(2, 2, 'NORTH')).to eql(rendered_robot)
  end

  it 'Checks if inputs X & Y are negative numbers' do
    expect(test_commands.negative_input(2, 2)).to eql(true)
    expect(test_commands.negative_input(-2, 4)).not_to eql(true)
    expect(test_commands.negative_input(2, -4)).not_to eql(true)
    expect(test_commands.negative_input(-2, -4)).not_to eql(true)
  end

  it 'Checks if inputs X & Y within board limits' do
    expect(test_commands.valid_tile(2, 2)).to eql(true)
    expect(test_commands.valid_tile(22, 32)).not_to eql(true)
  end

  it 'Checks and returns true if inputs are valid.' do
    expect(test_commands.valid_placement(2, 2, 'NORTH')).to eql(true)
    expect(test_commands.valid_placement(-2, 2, 'NORTH')).not_to eql(true)
    expect(test_commands.valid_placement(22, 2, 'NORTH')).not_to eql(true)
  end

  it 'Changes the position of the robot based on current direction.' do
    test_commands2 = RobotV2::Commands.new
    test_commands2.create_new_board(5)
    test_commands2.update_robot_position(0, 0, 'NORTH')
    new_position = { position: [1, 0], direction: 'NORTH' }
    expect(test_commands2.move_robot).to eql(new_position)
  end

  it 'Reverts the position of the robot back to its previous state.' do
    test_commands2 = RobotV2::Commands.new
    test_commands2.create_new_board(5)
    test_commands2.update_robot_position(1, 0, 'NORTH')
    new_position = { position: [0, 0], direction: 'NORTH' }
    expect(test_commands2.revert_robot).to eql(new_position)
  end

  it 'Turns the robot left.' do
    test_commands3 = RobotV2::Commands.new
    test_commands3.create_new_board(5)
    test_commands3.update_robot_position(0, 0, 'NORTH')
    new_direction_left = { position: [0, 0], direction: 'WEST' }
    expect(test_commands3.turn_left).to eql(new_direction_left)
  end

  it 'Turns the robot left.' do
    test_commands4 = RobotV2::Commands.new
    test_commands4.create_new_board(5)
    test_commands4.update_robot_position(0, 0, 'NORTH')
    new_direction_right = { position: [0, 0], direction: 'EAST' }
    expect(test_commands4.turn_right).to eql(new_direction_right)
  end

  it 'Displays the the current state of both the Board and Robort.' do
    test_commands5 = RobotV2::Commands.new
    test_commands5.create_new_board(5)
    test_commands5.update_robot_position(4, 4, 'NORTH')
    test_commands5.valid_placement(4, 4, 'NORTH')
    expect(test_commands5.report_position).to eql(true)
  end
end
