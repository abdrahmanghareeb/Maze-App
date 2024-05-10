import 'package:ai_maze_project/Cubit/maze_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Shared/components.dart';

class HomeLayout2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MazeCubit()..intializeTheMaze(),
      child: BlocConsumer<MazeCubit, MazeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = MazeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("Maze App"),
            ),
            body: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        algorithmDropdown(
                          selectedItem: cubit.selectedAlgorithm,
                          list: cubit.algorithmsList,
                          function: (value) {
                            cubit.changeAlgorithm(value);
                          },
                        ),
                        algorithmDropdown(
                          selectedItem: cubit.selectedMode,
                          list: cubit.modeList,
                          function: (value) {
                              cubit.changeMode(value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        defaultField(
                            function: (value) {
                                cubit.changeRow(value);
                            },
                            text: "Rows",
                            controllers: cubit.rowsControllers),
                        defaultField(
                            function: (value) {
                              cubit.changeColumn(value);
                            },
                            text: "Columns",
                            controllers: cubit.columnsControllers),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        defaultField(
                            function: (value) {
                                cubit.changeStartRow(value);
                            },
                            text: "Start point Row",
                            controllers: cubit.startRowControllers),
                        defaultField(
                            function: (value) {
                              cubit.changeStartColumn(value);
                            },
                            text: "Start point Column",
                            controllers: cubit.startColumnControllers),
                        defaultField(
                            function: (value) {
                                cubit.changeEndRow(value);
                            },
                            text: "End point Row",
                            controllers: cubit.endRowControllers),
                        defaultField(
                            function: (value) {
                              cubit.changeEndColumn(value);
                            },
                            text: "End point Column",
                            controllers: cubit.endColumnControllers),
                      ],
                    ),
                  ),
                ),
                matrix_builder(maze: cubit.maze, context: context, selectedMode: cubit.selectedMode ,startCol: cubit.startColumnControllers  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
