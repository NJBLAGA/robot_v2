require 'robot_v2/board'

test_board = RobotV2::Board.new

RSpec.describe RobotV2::Board do
  board25 = [["X", "X", "X", "X", "X"], ["X", "X", "X", "X", "X"], ["X", "X", "X", "X", "X"], ["X", "X", "X", "X", "X"], ["X", "X", "X", "X", "X"]]

  it 'Creates a 2D Array based on arg of size' do
    expect(test_board.create_board(5)).to eql(board25)
  end

  it "Updates robot's last position to X" do
    expect(test_board.update_last_position).to eql('X')
  end

  it "Updates robot's current position to R" do
    expect(test_board.place_robot(4, 4)).to eql('R')
  end

  it 'Displays the current position of robot on board' do
    board_display = test_board.draw_board
    expect(test_board.display_board(4, 4)).to eql(board_display)
    expect(test_board.display_board(0, 0)).to eql(board_display)
  end
end
