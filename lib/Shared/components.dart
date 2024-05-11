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


Widget matrix_builder({required List<List<int>> maze, required context ,required  int startCol ,
  required int endCol, required int endRow , required int startRow, required String selectedMode
}) {
  //iterate on the whole maze turn all the 7s and 10s to 0
  for (int i = 0; i < maze.length; i++) {
    for (int j = 0; j < maze[i].length; j++) {
      if (maze[i][j] == 7 || maze[i][j] == 10) {
        maze[i][j] = 0;
      }
    }
  }
  // Set the new start and end positions
  //important to chack the range first
  if (startRow >= 0 && startRow < maze.length && startCol >= 0 && startCol < maze[0].length) {
    maze[startRow][startCol] = 7;
  }
  if (endRow >= 0 && endRow < maze.length && endCol >= 0 && endCol < maze[0].length) {
    maze[endRow][endCol] = 10;
  }
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

// Widget matrix_builder({
//   required List<List<int>> maze,
//   required context,
//   required int startCol,
//   required int endCol,
//   required int endRow,
//   required int startRow,
//   required String selectedMode
// }) {
//   // Iterate over the whole maze and turn all the 7s and 10s to 0
//   for (int i = 0; i < maze.length; i++) {
//     for (int j = 0; j < maze[i].length; j++) {
//       if (maze[i][j] == 7 || maze[i][j] == 10) {
//         maze[i][j] = 0;
//       }
//     }
//   }
//   // Set the new start and end positions
//   if (startRow >= 0 && startRow < maze.length && startCol >= 0 && startCol < maze[0].length) {
//     maze[startRow][startCol] = 7;
//   }
//   if (endRow >= 0 && endRow < maze.length && endCol >= 0 && endCol < maze[0].length) {
//     maze[endRow][endCol] = 10;
//   }
//
//   return Expanded(
//     child: Stack(
//       children: [
//         Container(color: Colors.brown),
//         Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: GridView.builder(
//             itemCount: maze.length * maze[0].length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: maze[0].length,
//             ),
//             itemBuilder: (BuildContext context, int index) {
//               int row = index ~/ maze[0].length;
//               int col = index % maze[0].length;
//               var cubit = MazeCubit.get(context);
//               return InkWell(
//                 onTap: () {
//                   if (selectedMode == "Creation Mode") {
//                     if (maze[row][col] == 1) {
//                       maze[row][col] = 0;
//                     } else if (maze[row][col] == 0) {
//                       maze[row][col] = 1;
//                     }
//                     cubit.changeOnCellClick();
//                     print(maze.toString());
//                   }
//                 },
//                 child: _buildCell(value: maze[row][col]),
//               );
//             },
//           ),
//         ),
//       ],
//     ),
//   );
// }

