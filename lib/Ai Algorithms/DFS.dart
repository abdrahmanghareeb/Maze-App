// void main() {
//   List<List<int>> maze = [
//     [0, 1, 1, 0, 0],
//     [0, 1, 0, 1, 0],
//     [0, 0, 0, 1, 0],
//     [0, 1, 0, 0, 0],
//     [0, 0, 0, 0, 0]
//   ];
//   List<int> start = [0, 0];
//   List<int> end = [4, 4];
//
//   List<List<int>> solveByDFS(List<int> start, List<int> end, List<List<int>> maze) {
//     List<List<int>> visited = List.generate(maze.length, (index) => List.filled(maze[0].length, 0));
//     Map<List<int>, List<int>> parent = {};
//     List<List<int>> moves = [[1, 0], [-1, 0], [0, 1], [0, -1]];
//
//     bool isValidMove(int row, int col) {
//       return (row >= 0 &&
//           row < maze.length &&
//           col >= 0 &&
//           col < maze[0].length &&
//           maze[row][col] == 0 &&
//           visited[row][col] == 0);
//     }
//
//     List<List<int>> dfs(List<int> current) {
//       List<List<int>> stack = [current];
//
//       while (stack.isNotEmpty) {
//         current = stack.removeLast();
//         visited[current[0]][current[1]] = 1;
//
//         if (current[0] == end[0] && current[1] == end[1]) {
//           List<List<int>> path = [];
//           while (current[0] != start[0] || current[1] != start[1]) {
//             path.add(current);
//             current = parent[current]!;
//           }
//           path.add(start);
//           var path1 = path.reversed;
//           print("Path found: ${path1}");
//           // print("Path found: ${path[0]}");
//           // print("Path found: ${path[0][0]}");
//           // print("Path found: ${path[0][1]}");
//           // print("Path found: ${path.length}");
//           // print("Path found: ${path[path.length - 1][0]}");
//           return;
//         }
//
//         for (var move in moves) {
//           int newRow = current[0] + move[0];
//           int newCol = current[1] + move[1];
//           if (isValidMove(newRow, newCol)) {
//             List<int> neighbor = [newRow, newCol];
//             stack.add(neighbor);
//             parent[neighbor] = current;
//           }
//         }
//       }
//       print("No path found.");
//     }
//
//     dfs(start);
//     return dfs(start, end, maze);
//   }
//
//   solveByDFS(start, end, maze);
// }
