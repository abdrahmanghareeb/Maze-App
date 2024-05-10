import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget _buildCell(int value) {
  Color color = value == 1 ? Colors.black : Colors.white;
  return Container(
    margin: EdgeInsets.all(1),
    color: color,
  );
}

Widget algorithmDropdown(
    {required ValueChanged function, required selectedItem, required List<String> list}) {
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

// Widget defaultField(
//     {required ValueChanged function, required text, required controllers}) {
//   return Expanded(
//       child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: TextFormField(
//       controller: controllers,
//       keyboardType: TextInputType.number,
//       onFieldSubmitted: function,
//       decoration: InputDecoration(hintText: "$text"),
//     ),
//   ));
// }
Widget defaultField(
    {required ValueChanged function, required String text, required TextEditingController controllers }) {
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


Widget matrix_builder({required List<List<int>> maze , required context, required selectedMode}) {
  return Expanded(
    child: GestureDetector(
      onTapUp: (details) {
        // Calculate the tapped cell
        double cellWidth = MediaQuery.of(context).size.width / maze[0].length;
        double cellHeight =
            (MediaQuery.of(context).size.height - 120) / maze.length;
        int row = (details.localPosition.dy / cellHeight).floor();
        int col = (details.localPosition.dx / cellWidth).floor();

        // Update maze based on selected mode
          if (selectedMode == "Creation Mode") {
            if (maze[row][col] == 0) {
              maze[row][col] = 1; // Set barrier
            } else {
              maze[row][col] = 0; // Remove barrier
            }
          }
      },
      child: Stack(
        children: [
          Container(color: Colors.black12),
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
                return _buildCell(maze[row][col]);
              },
            ),
          ),
        ],
      ),
    ),
  );
}