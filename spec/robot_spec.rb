require 'robot_v2/robot'

test_robot = RobotV2::Robot.new

RSpec.describe RobotV2::Robot do
  it 'Assigns robot a position' do
    expect(test_robot.assign_position(0, 0)).to eql([0, 0])
    expect(test_robot.assign_position(4, 4)).to eql([4, 4])
    expect(test_robot.assign_position(3, 2)).to eql([3, 2])
  end

  it 'Assigns robot a direction' do
    expect(test_robot.assign_direction('North')).to eql('North')
    expect(test_robot.assign_direction('East')).to eql('East')
    expect(test_robot.assign_direction('West')).to eql('West')
    expect(test_robot.assign_direction('South')).to eql('South')
  end
end
