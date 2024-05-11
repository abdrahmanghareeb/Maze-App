import 'package:ai_maze_project/Ai%20Algorithms/BFS.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'maze_state.dart';

class MazeCubit extends Cubit<MazeState> {
  MazeCubit() : super(MazeInitial());

  static MazeCubit get(context) => BlocProvider.of(context);

  //lists and selected for the drop down menu's
  var algorithmsList = ["BFS", "DFS", "A*"];
  var modeList = ["Creation Mode", "Simulation Mode"];
  var selectedAlgorithm = "";
  var selectedMode = "";

  //controllers
  var rowsControllers = TextEditingController();
  var columnsControllers = TextEditingController();
  var startRowControllers = TextEditingController();
  var startColumnControllers = TextEditingController();
  var endRowControllers = TextEditingController();
  var endColumnControllers = TextEditingController();

  //to transform the controllers to int
  int? x;
  int? y;

  // start and end positions
  var startRow;
  var SR;
  var startColumn;
  var SC;
  var endRow;
  var ER;
  var endColumn;
  var EC;

  // Lists of solutions
  Iterable<List<int>> BFS_List = [];
  Iterable<List<int>> DFS_List = [];
  Iterable<List<int>> A_star_List = [];

  //the maze matrix
  var maze;

  void intializeTheMaze() {
    maze = List.generate(6, (index) => List.filled(6, 0)); // begin with 6*6
    selectedAlgorithm = algorithmsList.first; // BFS auto selected
    selectedMode = modeList.first; // Simulation Mode
    startRow = 0; // start point (0,0)
    startColumn = 0;
    endRow = 0; // end point (0,0)
    endColumn = 1;
    emit(IntializeMazeState());
  }

  void changeAlgorithm(value) {
    selectedAlgorithm = value;

    if (selectedAlgorithm == "BFS") {
      search_BFS(); // FIND SOLUTION
      eraseOldSearchPath(maze); // Erase all the 15 numbers in the maze first
      changeMazeValues(
          BFS_List); // iterate on solution and assign the maze items maze by 15
    } else if (selectedAlgorithm == "DFS") {
      search_DFS(); // FIND SOLUTION
      eraseOldSearchPath(maze); // Erase all the 15 numbers in the maze first
      changeMazeValues(
          DFS_List); // iterate on solution and assign the maze items maze by 15
    } else if (selectedAlgorithm == "A*") {
      search_A_star(); // FIND SOLUTION
      eraseOldSearchPath(maze); // Erase all the 15 numbers in the maze first
      changeMazeValues(
          A_star_List); // iterate on solution and assign the maze items maze by 15
    }
    emit(AlgorithmsState());
  }

  void changeMode(value) {
    selectedMode = value;
    eraseOldSearchPath(maze);
    if (selectedMode == "Simulation Mode") {
      changeAlgorithm(selectedAlgorithm);
    }
    emit(ModeState());
  }

  void changeRow(value) {
    try {
      x = int.tryParse(value) ?? 1;
      //
      if (x != null && y != null) {
        if (x! > 0 && y! > 0 && x! < maze.length && y! < maze[0].length) {
          maze = List.generate(x!, (index) => List.filled(y!, 0));
          startRow = 0; // start point (0,0)
          startColumn = 0;
          endRow = 0; // end point (0,0)
          endColumn = 1;
          emit(RowState());
        } else {
          intializeTheMaze();
          emit(RowErrorState());
        }
      } else {
        intializeTheMaze();
        emit(RowErrorState());
      }}catch(e){
        print(e.toString());
    }
  }

  void changeColumn(value) {
    y = int.tryParse(value) ?? 1;
    if (x != null && y != null) {
      if (x! > 0 && y! > 0) {
        maze = List.generate(x!, (index) => List.filled(y!, 0));
        emit(ColumnState());
      } else {
        intializeTheMaze();
        emit(ColumnErrorState());
      }
    } else {
      intializeTheMaze();
      emit(ColumnErrorState());
    }
  }

  // void changeColumn(value) {
  //   try {
  //     y = int.tryParse(value) ?? 1;
  //     //
  //     if (x != null && y != null) {
  //       if (x! > 0 && y! > 0 && x! < maze.length && y! < maze[0].length) {
  //         maze = List.generate(x!, (index) => List.filled(y!, 0));
  //         startRow = 0; // start point (0,0)
  //         startColumn = 0;
  //         endRow = 0; // end point (0,0)
  //         endColumn = 1;
  //         emit(ColumnState());
  //       } else {
  //         intializeTheMaze();
  //         emit(ColumnErrorState());
  //       }
  //     } else {
  //       intializeTheMaze();
  //       emit(ColumnErrorState());
  //     }
  //   }catch(e){
  //     print(e.toString());
  //   }
  // }

  // to change the start and end point you need to return the old end and start to the normal state
  // ensure that both row and column fields are valid
  void changeStart() {
    //check not null and not exceed the maze size
    if (SR != null && SC != null && selectedMode == "Creation Mode") {
      if (SR < maze.length && SC < maze[0].length) {
        startRow = SR;
        startColumn = SC;
        emit(StartState());
        // changeAlgorithm(selectedAlgorithm);
      }
    }
  }

  void changeEnd() {
    if (ER != null && EC != null && selectedMode == "Creation Mode") {
      if (ER < maze.length && EC < maze[0].length) {
        endRow = ER;
        endColumn = EC;
        emit(EndState());
        // changeAlgorithm(selectedAlgorithm);
      }
    }
  }

  //to change the maze start point
  void changeStartRow(value) {
    SR = int.tryParse(value) ?? 0;
    emit(StartCellRowState());
    changeStart();
  }

  void changeStartColumn(value) {
    SC = int.tryParse(value) ?? 0;
    emit(StartCellColumnState());
    changeStart();
  }

  //to change the maze end point
  void changeEndRow(value) {
    ER = int.tryParse(value) ?? 0;
    emit(EndCellRowState());
    changeEnd();
  }

  void changeEndColumn(value) {
    EC = int.tryParse(value) ?? 1;
    emit(EndCellColumnState());
    changeEnd();
  }

  //toggle the cell between (white and black) color when the
  void changeOnCellClick() {
    emit(OnCellClickState());
  }

  //erase the old solution
  void eraseOldSearchPath(maze) {
    for (int i = 0; i < maze.length; i++) {
      for (int j = 0; j < maze[i].length; j++) {
        if (maze[i][j] == 15) {
          maze[i][j] = 0;
        }
      }
    }
  }

  void changeMazeValues(SolutionList) {
    if (SolutionList.isNotEmpty) {
      for (List<int> coordinate in SolutionList) {
        int row = coordinate[0];
        int col = coordinate[1];
        // Check if the coordinate is within the bounds of the maze
        if (row >= 0 &&
            row < maze.length &&
            col >= 0 &&
            col < maze[row].length) {
          // Update the value in the maze to 15
          maze[row][col] = 15;
        }
      }
    }
  }

  //============================= solve by BFS ==================
  void search_BFS() {
    BFS_List = solveByBFS(
        start: [startRow, startColumn], end: [endRow, endColumn], maze: maze);
    print("path : ${BFS_List}");
    emit(search_State());
  }

  //============================= solve by DFS ==================
  void search_DFS() {
    emit(search_State());
  }

  //============================= solve by A* ==================
  void search_A_star() {
    emit(search_State());
  }
}