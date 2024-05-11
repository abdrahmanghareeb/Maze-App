import 'dart:collection';

// List<List<int>> maze = [
//   [0, 1, 0, 0, 0],
//   [0, 1, 0, 1, 0],
//   [0, 0, 0, 0, 0],
//   [0, 1, 1, 1, 0],
//   [0, 0, 0, 0, 0]
// ];
// List<int> start = [2, 3];
// List<int> end = [4, 4];

Iterable<List<int>> solveByBFS(
    {required List<int> start, required List<int> end,required List<List<int>> maze}) {
  Iterable<List<int>> result = [];
  if ((start[0] >= 0 && start[0] < maze.length && start[1] >= 0 &&
      start[1] < maze[0].length && maze[start[0]][start[1]] != 1) ||
      (end[0] >= 0 && end[0] < maze.length && end[1] >= 0 &&
          end[1] < maze[0].length && maze[end[0]][end[1]] != 1)) {
    Set<List<int>> visited = {};
    Map<List<int>, List<int>> parent = {};
    List<List<int>> moves = [ [0, 1], [0, -1], [1, 0], [-1, 0]];

    List<List<int>> getNeighbors(List<int> current) {
      List<List<int>> neighbors = [];
      for (var move in moves) {
        int newRow = current[0] + move[0];
        int newCol = current[1] + move[1];
        if (newRow >= 0 && newRow < maze.length && newCol >= 0 &&
            newCol < maze[0].length && maze[newRow][newCol] != 1) {
          neighbors.add([newRow, newCol]);
        }
      }
      return neighbors;
    }

    Iterable<List<int>> bfs(List<int> start, List<int> end) {
      Queue<List<int>> queue = Queue();
      queue.add(start);

      while (queue.isNotEmpty) {
        List<int> current = queue.removeFirst();
        visited.add(current);

        if (current[0] == end[0] && current[1] == end[1]) {
          List<List<int>> path = [];
          while (current[0] != start[0] || current[1] != start[1]) {
            path.add(current);
            current = parent[current]!;
          }
          path.add(start);
          result = path.reversed ;
          print("Path found: ${result}");
          return path.reversed.toList();
        }

        for (var neighbor in getNeighbors(current)) {
          if (!visited.contains(neighbor)) {
            queue.add(neighbor);
            parent[neighbor] = current;
          }
        }
      }
      print("No path found.");
      return result;
    }
    return bfs(start, end);
  } else {
    print("Not valid.");
    return [];
  }
}

// void main () {
//   print(solveByBFS(start: start , maze: maze , end: end));
// }