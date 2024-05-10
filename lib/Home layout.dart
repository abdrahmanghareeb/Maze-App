// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
//
// class HomeLayout extends StatefulWidget {
//   @override
//   State<HomeLayout> createState() => _HomeLayoutState();
// }
//
// var algorithms_list = ["BFS", "DFS", "A*"];
//
// var mode_list = ["Creation mode", "Simulation mode"];
//
// var mode = "Creation Mode";
//
// var selected_algorithm = "";
// var selected_mode = "";
//
// var maze = [
//   [0, 1, 0, 0, 0, 0, 0],
//   [0, 1, 0, 0, 0, 0, 0],
//   [0, 0, 0, 0, 1, 1, 0],
//   [0, 1, 1, 1, 0, 1, 0],
//   [0, 0, 1, 0, 1, 0, 0],
//   [0, 0, 1, 0, 0, 0, 0],
//   [0, 0, 0, 1, 0, 0, 0],
//   [0, 0, 0, 1, 0, 1, 1],
// ];
//
// var start = (0,0);
// var end = (4,4);
//
// class _HomeLayoutState extends State<HomeLayout> {
//   var dropdown_Value = algorithms_list.first;
//   var dropdown_mode_Value = mode_list.first;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Maze App"),
//         ),
//         body: Column(
//           children: [
//             SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Container(
//                   width: double.infinity,
//
//                   color: Colors.grey,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       algorithm_dropdown(
//                         list: algorithms_list,
//                         function: (value) {
//                           // This is called when the user selects an item.
//                           setState(() {
//                             dropdown_Value = value!;
//                             selected_algorithm = dropdown_Value.toString();
//                             print(dropdown_Value.toString());
//                             print(selected_algorithm);
//                           });
//                         },
//                       ),
//                       algorithm_dropdown(
//                         list: mode_list,
//                         function: (value) {
//                           // This is called when the user selects an item.
//                           setState(() {
//                             dropdown_mode_Value = value!;
//                             selected_mode = dropdown_mode_Value.toString();
//                             print(dropdown_mode_Value.toString());
//                             print(selected_mode);
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Expanded(
//               child: Stack(
//                 children: [
//                   Container(
//                     color: Colors.orangeAccent,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: buildMazeUI(maze),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ));
//   }
// }
//
// Widget buildMazeUI(List<List<int>> maze) {
//   return GridView.builder(
//     itemCount: maze.length * maze[0].length,
//     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: maze[0].length,
//     ),
//     itemBuilder: (BuildContext context, int index) {
//       int row = index ~/ maze[0].length;
//       int col = index % maze[0].length;
//       return InkWell(child: _buildCell(maze[row][col]) , onTap: () {
//
//       },);
//     },
//   );
// }
//
// Widget _buildCell(int value) {
//   Color color = value == 1 ? Colors.black : Colors.white;
//   return Container(
//     margin: EdgeInsets.all(1),
//     color: color,
//   );
// }
//
// Widget algorithm_dropdown({required ValueChanged function, required list}) {
//   return Expanded(
//     child: DropdownMenu<String>(
//       initialSelection: list.first,
//       onSelected: function,
//       dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
//         return DropdownMenuEntry<String>(
//           value: value,
//           label: value,
//         );
//       }).toList(),
//     ),
//   );
// }
