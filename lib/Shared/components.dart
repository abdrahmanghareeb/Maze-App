import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Cubit/maze_cubit.dart';

Widget _buildCell({required int value}) {
  // assign 0 -> space , 1 => border ,7 => start , 10 => end
  Color color = Colors.white;
  if (value == 1) {
    color = Colors.black;
  } else if (value == 0) {
    color = Colors.white;
  } else if (value == 7) {
    color = Colors.blueAccent;
  } else if (value == 10) {
    color = Colors.red;
  }else if (value == 15) {
    color = Colors.orange;
  }
  return Container(
    margin: EdgeInsets.all(1),
    color: color,
  );
}

Widget algorithmDropdown(
    {required ValueChanged function,
    required selectedItem,
    required List<String> list}) {
  return Expanded(
    child: DropdownButton<String>(
      value: selectedItem,
      onChanged: (String? value) {
        function(value);
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
  );
}

Widget defaultField(
    {required ValueChanged function,
    required String text,
    required TextEditingController controllers}) {
  return Expanded(
      child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: controllers,
      keyboardType: TextInputType.number,
      onChanged: function,
      decoration: InputDecoration(hintText: "$text"),
    ),
  ));
}

// Widget matrix_builder({required List<List<int>> maze, required context}) {
//   var cubit = MazeCubit.get(context);
//   return Expanded(
//     child: GestureDetector(
//       onTapUp: (details) {
//         // Calculate the tapped cell
//         double cellWidth = MediaQuery.of(context).size.width / maze[0].length;
//         double cellHeight =
//             (MediaQuery.of(context).size.height - 120) / maze.length;
//
//         // Calculate column index based on tap position
//         int col = (details.localPosition.dx / cellWidth).floor();
//
//         // Calculate row index based on tap position
//         int row = (details.localPosition.dy / cellHeight).floor();
//
//         // Toggle the cell color (0 -> 1, 1 -> 0)
//         cubit.toggleCell(row, col);
//       },
//       child: Stack(
//         children: [
//           Container(color: Colors.black12),
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: GridView.builder(
//               itemCount: maze.length * maze[0].length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: maze[0].length,
//               ),
//               itemBuilder: (BuildContext context, int index) {
//                 int row = index ~/ maze[0].length;
//                 int col = index % maze[0].length;
//                 return _buildCell(value: maze[row][col]);
//               },
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

Widget matrix_builder({required List<List<int>> maze, required context ,required startCol ,
  required endCol, required endRow , required startRow, required String selectedMode
}) {
  //iterate on the whole maze turn all the 7s and 10s to 0
  for (int i = 0; i < maze.length; i++) {
    for (int j = 0; j < maze[i].length; j++) {
      if (maze[i][j] == 7 || maze[i][j] == 10) {
        maze[i][j] = 0;
      }
    }
  }
  //set the new start and end
  maze[startRow][startCol] = 7;
  maze[endRow][endCol] = 10;
  return Expanded(
    child: Stack(
      children: [
        Container(color: Colors.brown),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.builder(
            itemCount: maze.length * maze[0].length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: maze[0].length,
            ),
            itemBuilder: (BuildContext context, int index) {
              int row = index ~/ maze[0].length;
              int col = index % maze[0].length;
              var cubit = MazeCubit.get(context);
              return InkWell(
                  onTap: () {
                    if(selectedMode == "Creation Mode") {
                      if (maze[row][col] == 1) {
                        maze[row][col] = 0;
                      } else if (maze[row][col] == 0) {
                        maze[row][col] = 1;
                      }
                      cubit.changeOnCellClick();
                      print(maze.toString());
                    }
                  },
                  child: _buildCell(value: maze[row][col]));
            },
          ),
        ),
      ],
    ),
  );
}
