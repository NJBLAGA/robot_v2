# RobotV2

## Nathan Blaga Toy Robot Challenge Repo [https://github.com/NJBLAGA/robot_v2]

## Instructions

Follow the below steps to successfully install and run `RobotV2`

1. Head over to the project's GitHub page at `https://github.com/NJBLAGA/robot_v2`
1. Click on the green button labelled `code`
1. Copy either the HTTPS or SSH link.
1. In your terminal, head to the directory/folder of your choice (where you want to store your project)
1. Type the following command `git clone xxxxxxxxxxxxx` (xxxx denoting the copied link from step 3)
1. This command will then proceed to clone the `robot_v2` repo to your local machine
1. Navigate to your local cloned copy of `robot_v2` by using `cd robot_v2` in your terminal
1. Using `bundle install` , install the projects required dependencies and gems.'
1. Once the above command has finished, open the project using the command `code .` (if using `VS Code`) or the text editor of your choice

## Run RobotV2

Once you are in the main directory of `RobotV2`, run the command `./bin/console` within your terminal.

## Run Rspec tests

Once you are in the main directory of `RobotV2`, run the command `bundle exec rspec spec` within your terminal.

## RobotV2 -- Mode Options

Once the above command is run, the main menu should be displayed on the screen. `RobotV2` offers two modes -- `Manual` and `Auto`.

### **Manual Mode:**

The player will be instructed to input various commands. If valid commands are used, the player will be able to place, move, turn and re-place the `Robot` on the `Board`.

### **Auto Mode:**

Once `Auto Mode` is selected,`RobotV2` will prompt the player for a file. If valid commands are read, `RobotV2` will read the file and instruct the `Robot`. Like `Manual Mode`, invalid commands will be ignored.

**REQUIRED FORMAT OF FILES:**

When prompted, all that is required is is the file name (excluding file_type).

**Example:**

Test-File: `test_1.txt` located within the `test_files` folder.

When prompted in `Auto Mode`, all that is needed is: `test_1`.

**NOTE:** -- For `Auto Mode` to correctly function, any test file to be executed `MUST` be stored within `test_files`.

**REQUIRED FORMAT FOR TEST FILE:**

Any given test file can only contain the below commands to result in valid commands being executed. Each file can contain duplicate commands and have no command limit.

- PLACE 0,0,NORTH
- MOVE
- LEFT
- RIGHT
- REPORT

**EXAMPLE:**

```plain
PLACE 0,0,NORTH
MOVE
REPORT
```

## Tech Stack

- Ruby v2.7.2

## Dependencies

- gem "rake", "~> 13.0"
- gem "rspec", "~> 3.0"

## Self-Reflection

As a second attempt at building a solution for this challenge, I focused on improving the overall performance, effectiveness and structure of my original solution.
The below points illustrate my thought process and areas which I focused on improving throughout development:

- More concise folder/file structure
  After the pairing session alongside notes, using `bundle gem robot_v2` commands allowed me to construct the project.
- Utilising `Ruby rubocop`, I was about to better construct more refined methods and code structure compared to my first attempt.

**Following standards, I focused on the following:**

- Maintaining a OO approach, utilising `Ruby` modules and classes
- Allocating class methods to a `1 purpose` structure -- low coupling/high cohesion (--However various method's logic within the codebase could still be refined and improved upon)

**Testing:**

The `rspec` gem was utilised to conduct unit testing on the `Board`, `Robot` and `Commands` classes.

While designing tests for each class, I focused on the following:

- I aimed to ensure each method was designed for a single purpose rather than performing several tasks.
- I aimed to reduce nest logic within all methods.
- I still wish to improve my testing knowledge and experience. I feel the more exposure I can have to unit-testing, will result in improving my overall approach to testing.

## Assumptions

- I designed the `Board` class method `create_board(size)` to take an argument of `size`
- This allows the application the functionality to expand the size of the `Board` being played on.
- However within the code base, at the present time, the `size` is hard-coded in at `5` on `line 20` within the file `game.rb`.
- Further improvements are needed on the way the code handles `board` construction with huge inputs. The time alongside space complexity of the construction of the `board` and traversing it, would result in slow performance at the code's current state.
- Player experience was heavily focused on by ensuring begin, rescue blocks were incorporated within the code-base. Error-handling has been place throughout various levels of the code to handle any invalid input/commands being used.
- Although handling the players input/commands has been handled in a more graceful manner compared to me first attempt, improvements could be made to reduce the doubling-up of code.
- Naming of Classes and variables was a focus throughout development, while still a work in progress, I aimed in ensuring the names were suggestive to any reader.

## PATH_FINDING Challenge Assumptions / Self-Reflection

- The `path` command takes a `target_position` selected by the player
- The command uses the `current position` of the Robot as the starting point
- This means the command cannot be used and executed unless the Robot is on the board.
- The `filter_commands` method in the `game` class replaced the `filter_place` and `filter_obstacle` command previously used.
- I don't like it as a method, as it violates SOLID principles, does not benefit the class speaking within a OO mindset, and narrows the error-handling around the three commands.

**The `Command` class uses several methods to execute the `Path` command:**

- This solution does not address the advanced problem of returning the set of commands needed to move and turn the robot from starting position to the target position.
- find_path(path_position_x, path_position_y) takes the `x` and `y` positioning selected by the player and returns the `find_position` method
- find_optimised_path(board, current_position, target_position, obstacles)
  Returns the `possible_paths` method, which returns the `possible_path_list` array, of all possible paths from the Robot's current position to the target position. It takes the `possible_path_list`, sorts it by size and returns the first element (smallest in size). Not the most optimal way as there could be multiple paths with the same size in regards to steps taken.
- find_adjacent_tiles_to_current_position(board, current_position, obstacles)
  First returns `all_current_adjacent_tiles` variables, this contains all possible movements the Robot can take from it's current position. The variable (array) is then filtered through the `select` method. This will remove any tiles that are not within the board's limitations and any tiles that currently have an obstacle on them.
- possible_paths(board, current_position, target_position, current_path_taken, possible_path_list, obstacles)
  Using recursion, this method sets the base case to check if the Robot's current position is equal to that of the target_position or if a visited position is revisited. If this is the case, the last current position should equal the target position and the terminate the loop by returning `possible_path_list` to the `find_optimised_path` method. If the the base case has not been met, then `possible_paths` method will call itself in a endless loop. This will lead to a for each loop being run on the array returned from `current_path_taken` method. Within each loop the method will check if the current tile (node) has been visited. If not then, the current array holding the selection of adjacent tiles will be copied and pushed into the `next_possible_path` array and used as the `current_path_taken` argument.

**Research:**

- Although I have tackled various algorithms throughout my boot-camp, this was one of the more difficult steps of the challenge.
- Dijkstra's algorithm was not the best option as each tile the Robot moved on, counts as 1 step, and could not be assigned values to effectively utilise Dijkstra. With this in mind, I decided to work with a `Breadth-First Search (BFS)` approach, which lead to my current solution.
- I decided to tackle the problem in smaller steps, in that I first tried to have the command return a path from the current position of the Robot to the target position without considering the obstacles. Once I achieved this, it was not to much effort to introduce the obstacles within the logic of the `path` command.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
