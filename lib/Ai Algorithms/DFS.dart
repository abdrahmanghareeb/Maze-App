List<List<int>> maze = [
  [0, 1, 0, 0, 0],
  [0, 1, 0, 1, 0],
  [0, 0, 0, 1, 0],
  [0, 1, 1, 1, 1],
  [0, 0, 0, 0, 0]
];

List<int> startPoint = [2, 2];
List<int> endPoint = [4, 4];


void main() {

  List<List<int>> path = solveMazeDFS(maze: maze,startPoint:startPoint,endPoint: endPoint);
  if (path.isEmpty) {
    print("No path found!");
  } else {
    print("Path found:");
    for (var point in path) {
      print(point);
    }
  }
}

List<List<int>> solveMazeDFS(
    {required List<List<int>> maze,required List<int> startPoint,required List<int> endPoint}) {
  int rows = maze.length;
  int cols = maze[0].length;

  List<List<bool>> visited = List.generate(rows, (_) => List.filled(cols, false));

  List<List<int>> path = [];
  dfs(maze, startPoint[0], startPoint[1], endPoint[0], endPoint[1], visited, path);

  return path;
}

bool dfs(List<List<int>> maze, int i, int j, int endRow, int endCol,
    List<List<bool>> visited, List<List<int>> path) {
  if (i < 0 || i >= maze.length || j < 0 || j >= maze[0].length ||
      maze[i][j] == 1 || visited[i][j]) {
    return false;
  }

  path.add([i, j]);
  visited[i][j] = true;

  if (i == endRow && j == endCol) {
    return true;
  }

  // Explore in all four directions (up, down, left, right)
  if (dfs(maze, i + 1, j, endRow, endCol, visited, path) ||
      dfs(maze, i - 1, j, endRow, endCol, visited, path) ||
      dfs(maze, i, j + 1, endRow, endCol, visited, path) ||
      dfs(maze, i, j - 1, endRow, endCol, visited, path)) {
    return true;
  }

  // If no path is found, backtrack
  path.removeLast();
  return false;
}
