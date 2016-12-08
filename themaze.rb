load 'lib/maze.rb'

# Create a new object
m = Maze.new

# Solve maze
route = m.solve_bfs

# Print solution (route)
puts ""
puts "Route: "
puts "-----------------------"
p route