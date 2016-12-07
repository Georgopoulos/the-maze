class Maze

  def initialize
    # Ask user to insert filename
    puts "Please insert a filename: "
    filename = gets.chomp

    # Read maze from a given file, remove new lines and split into arrays
    @maze = []

    File.open(filename) do |file|
      file.each_line { |line| @maze << line.strip.split('') }
    end


    # Locate Start and Finish points
    @maze.each.with_index do |line, x|
      line.each.with_index do |element, y|
        @start = [x,y] if element == "S"
        @finish =  [x,y] if element == "F"
      end
    end
  end

  def bfs
    node_queue = []
    visited_nodes = []
    traveled_path = []

    node_queue << @start
    visited_nodes << @start
    traveled_path << @start

    while !node_queue.empty?
      current_node = node_queue.shift
      x = current_node[0]
      y = current_node[1]

      neighbors = [[x, y + 1], [x, y - 1], [x + 1, y], [x - 1, y]]
      neighbors.each do |neighbor|
        if neighbor[0] > -1 && neighbor[1] > -1 && neighbor[0] < @maze.length  && neighbor[1] < @maze.first.length
          node = @maze[neighbor[0]][neighbor[1]]
          if !visited_nodes.include?(neighbor) && node != '#'
            node_queue << neighbor
            visited_nodes << neighbor
            # traveled_path << current_node if neighbors.include?(traveled_path.last)
            if node == 'F'
              traveled_path << neighbor
              p traveled_path
              return traveled_path
            end
          end
        end
      end
    end
  end

  m = Maze.new()
  m.bfs

end