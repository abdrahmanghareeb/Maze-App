import 'dart:math';

class Node {
  int row;
  int col;
  int f =0 ;
  int g= 0;
  int h= 0;
  late  Node? parent;
  Node(this.row, this.col , {required this.parent});
  @override
  String toString() {
    return '[$row, $col]';
  }
}



List<List<int>> aStarSearch(List<List<int>> maze, List<int> startPoint, List<int> endPoint) {
  int rows = maze.length;
  int cols = maze[0].length;

  List<List<bool>> closedList = List.generate(rows, (_) => List.filled(cols, false));
  List<List<Node>> nodes = List.generate(rows, (i) => List.generate(cols, (j) => Node(i, j, parent: null)));

  int startRow = startPoint[0];
  int startCol = startPoint[1];
  int endRow = endPoint[0];
  int endCol = endPoint[1];

  Node startNode = nodes[startRow][startCol];
  Node endNode = nodes[endRow][endCol];

  List<Node> openList = [startNode];

  startNode.g = 0;
  startNode.h = (startRow - endRow).abs() + (startCol - endCol).abs();
  startNode.f = startNode.g + startNode.h;

  while (openList.isNotEmpty) {
    openList.sort((a, b) => a.f.compareTo(b.f));
    Node currentNode = openList.first;

    if (currentNode.row == endRow && currentNode.col == endCol) {
      return reconstructPath(currentNode);
    }

    openList.remove(currentNode);
    closedList[currentNode.row][currentNode.col] = true;

    List<Node> neighbors = getNeighbors(currentNode, nodes, maze, rows, cols);

    for (Node neighbor in neighbors) {
      if (closedList[neighbor.row][neighbor.col]) {
        continue;
      }

      int tentativeGScore = currentNode.g + 1;

      if (!openList.contains(neighbor) || tentativeGScore < neighbor.g) {
        neighbor.parent = currentNode;
        neighbor.g = tentativeGScore;
        neighbor.h = (neighbor.row - endRow).abs() + (neighbor.col - endCol).abs();
        neighbor.f = neighbor.g + neighbor.h;

        if (!openList.contains(neighbor)) {
          openList.add(neighbor);
        }
      }
    }
  }

  return [];
}

List<Node> getNeighbors(Node node, List<List<Node>> nodes, List<List<int>> maze, int rows, int cols) {
  List<Node> neighbors = [];
  int row = node.row;
  int col = node.col;

  if (row > 0 && maze[row - 1][col] == 0) {
    neighbors.add(nodes[row - 1][col]);
  }
  if (row < rows - 1 && maze[row + 1][col] == 0) {
    neighbors.add(nodes[row + 1][col]);
  }
  if (col > 0 && maze[row][col - 1] == 0) {
    neighbors.add(nodes[row][col - 1]);
  }
  if (col < cols - 1 && maze[row][col + 1] == 0) {
    neighbors.add(nodes[row][col + 1]);
  }

  return neighbors;
}

List<List<int>> reconstructPath(Node node) {
  List<List<int>> path = [];
  while (node != null) {
    path.insert(0, [node.row, node.col]);
    node = node.parent!;
  }
  return path;
}

void main() {
  List<List<int>> maze = [
    [0, 1, 0, 0, 0],
    [0, 1, 0, 1, 0],
    [0, 0, 0, 1, 0],
    [1, 1, 1, 1, 0],
    [0, 0, 0, 0, 0]
  ];

  List<int> startPoint = [0, 0];
  List<int> endPoint = [4, 4];

  List<List<int>> path = aStarSearch(maze, startPoint, endPoint);
  if (path.isEmpty) {
    print("No path found!");
  } else {
    print("Path found:");
    for (var point in path) {
      print(point);
    }
  }
}
