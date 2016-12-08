class Maze

  def initialize
    # Ask user to insert filename
    puts "Please insert a filename: "
    filename = gets.chomp

    # Read maze from a given file, remove new lines and split into array
    @maze = []

    File.open(filename) do |file|
      file.each_line { |line| @maze << line.strip.split('') }
    end

    locate_start_finish
  end

  def locate_start_finish
    # Locate Start and Finish points
    @maze.each.with_index do |line, x|
      line.each.with_index do |element, y|
        @start = [x,y] if element == "S"
        @finish =  [x,y] if element == "F"
      end
    end
  end

  def directions(x,y)
    # Possible directions (movements)
    [[x, y + 1], [x, y - 1], [x + 1, y], [x - 1, y]]
  end

  def is_inside_maze?(point)
    # Check if point is between the limits of the Maze
    point[0] > -1 && point[1] > -1 && point[0] < @maze.length  && point[1] < @maze.first.length
  end

  def solve_bfs
    node_queue = Queue.new
    visited_nodes = []
    route = []
    finished = false

    node_queue << @start
    visited_nodes << @start

    until node_queue.empty?
      break if finished
      current_node = node_queue.deq
      x, y = current_node[0], current_node[1]
      directions = directions(x,y)
      directions.each do |point|
        if is_inside_maze?(point)
          node = @maze[point[0]][point[1]]
          # Check if node has been already visited or it is a wall
          if !visited_nodes.include?(point) && node != '#'
            node_queue << point
            visited_nodes << point
            # Check if finished
            finished = point == @finish
          end
        end
      end
    end

    visited_nodes = visited_nodes.reverse
    route << visited_nodes.first
    visited_nodes.shift
    visited_nodes.each do |node|
      x, y = node[0], node[1]
      directions = directions(x,y)
      route << node if directions.include?(route.last)
    end

    p route.reverse
    return route.reverse
  end
end