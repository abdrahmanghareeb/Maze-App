// import 'dart:collection';
//
// List<List<int>> maze = [
//   [0, 1, 0, 0, 0],
//   [0, 1, 0, 1, 0],
//   [0, 0, 0, 0, 0],
//   [0, 1, 1, 1, 0],
//   [0, 0, 0, 1, 0]
// ];
//
// class Node {
//   List<int> position;
//   Node? parent;
//   var g;
//   var h;
//   var f;
//
//   Node(this.position, {this.parent}) {
//     g = 0;
//     h = 0;
//     f = 0;
//   }
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//           other is Node &&
//               runtimeType == other.runtimeType &&
//               position == other.position;
//
//   @override
//   int get hashCode => position.hashCode;
// }
//
// List<List<int>> getNeighbors(List<int> current, List<List<int>> maze) {
//   List<List<int>> neighbors = [];
//   List<List<int>> moves = [
//     [1, 0],
//     [-1, 0],
//     [0, 1],
//     [0, -1]
//   ]; // Right, Left, Down, Up
//   for (List<int> move in moves) {
//     List<int> neighborPos = [current[0] + move[0], current[1] + move[1]];
//     if (neighborPos[0] >= 0 &&
//         neighborPos[0] < maze.length &&
//         neighborPos[1] >= 0 &&
//         neighborPos[1] < maze[0].length &&
//         maze[neighborPos[0]][neighborPos[1]] != 1) {
//       neighbors.add(neighborPos);
//     }
//   }
//   return neighbors;
// }
//
// int heuristic(List<int> current, List<int> goal) {
//   return (current[0] - goal[0]).abs() + (current[1] - goal[1]).abs();
// }
//
// List<List<int>> astar(List<List<int>> maze, List<int> start, List<int> end) {
//   List<Node> openList = [];
//   Set<List<int>> closedSet = HashSet<List<int>>();
//
//   Node startNode = Node(start);
//   startNode.g = startNode.h = startNode.f = 0;
//   openList.add(startNode);
//
//   while (openList.isNotEmpty) {
//     openList.sort((a, b) => a.f.compareTo(b.f));
//     Node currentNode = openList.removeAt(0);
//     closedSet.add(currentNode.position);
//
//     if (currentNode.position == end) {
//       List<List<int>> path = [];
//       while (currentNode != null) {
//         path.add(currentNode.position);
//         currentNode = currentNode.parent!;
//       }
//       return path.reversed.toList();
//     }
//
//     List<List<int>> neighbors = getNeighbors(currentNode.position, maze);
//     for (List<int> neighborPos in neighbors) {
//       if (closedSet.contains(neighborPos)) continue;
//
//       Node neighborNode = Node(neighborPos, parent: currentNode);
//       neighborNode.g = currentNode.g + 1;
//       neighborNode.h = heuristic(neighborPos, end);
//       neighborNode.f = neighborNode.g + neighborNode.h;
//
//       bool found = false;
//       for (int i = 0; i < openList.length; i++) {
//         Node n = openList[i];
//         if (n == neighborNode) {
//           found = true;
//           openList.removeAt(i);
//           break;
//         }
//       }
//
//       if (!found) {
//         openList.add(neighborNode);
//       } else {
//         Node existing = openList.firstWhere((n) => n == neighborNode);
//         if (neighborNode.g < existing.g) {
//           existing.g = neighborNode.g;
//           existing.f = existing.g + existing.h;
//           existing.parent = currentNode;
//         }
//       }
//     }
//   }
//
//   return [];
// }
//
// void solveByAStar(List<int> start, List<int> end, List<List<int>> maze) {
//   if ((start[0] >= 0 &&
//       start[0] < maze.length &&
//       start[1] >= 0 &&
//       start[1] < maze[0].length &&
//       maze[start[0]][start[1]] != 1) &&
//       (end[0] >= 0 &&
//           end[0] < maze.length &&
//           end[1] >= 0 &&
//           end[1] < maze[0].length &&
//           maze[end[0]][end[1]] != 1)) {
//     List<List<int>> path = astar(maze, start, end);
//     if (path.isNotEmpty) {
//       print("Path found: $path");
//     } else {
//       print("No path found.");
//     }
//   } else {
//     print("Not valid");
//   }
// }
//
// void main() {
//   List<int> start = [0, 0];
//   List<int> end = [4, 4];
//   solveByAStar(start, end, maze);
// }
