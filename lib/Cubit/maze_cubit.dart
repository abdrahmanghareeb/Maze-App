import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'maze_state.dart';

class MazeCubit extends Cubit<MazeState> {
  MazeCubit() : super(MazeInitial());

  static MazeCubit get(context) => BlocProvider.of(context);

  var algorithmsList = ["BFS", "DFS", "A*"];
  var modeList = ["Creation Mode", "Simulation Mode"];
  var selectedAlgorithm = "";
  var selectedMode = "";

  // var rowsNumber;
  // var columnsNumber;
  var rowsControllers = TextEditingController();
  var columnsControllers = TextEditingController();
  var startRowControllers = TextEditingController();
  var startColumnControllers = TextEditingController();
  var endRowControllers = TextEditingController();
  var endColumnControllers = TextEditingController();
  var startRow;
  var SR;
  var startColumn;
  var SC;
  var endRow;
  var ER;
  var endColumn;
  var EC;

  //to transform the controllers to int
  int? x;

  int? y;

  var maze;

  // // will carry the coordinates of start cell ( row , column ) => ( y, x )
  // List<int> start = [0, 0]; // Initialize start point
  // List<int> end = [4, 4];

  void intializeTheMaze() {
    maze = List.generate(6, (index) => List.filled(6, 0));
    selectedAlgorithm = algorithmsList.first;
    selectedMode = modeList.first;
    startRow = 0;
    startColumn = 0;
    // endRow = maze.length;
    // endColumn = maze[0].length;
    endRow = 0;
    endColumn = 1;
    emit(IntializeMazeState());
  }

  void changeAlgorithm(value) {
    selectedAlgorithm = value;
    emit(AlgorithmsState());
  }

  void changeMode(value) {
    selectedMode = value;
    emit(ModeState());
  }

  void changeRow(value) {
    x = int.tryParse(value) ?? 1;
    if (x != null && y != null) {
      maze = List.generate(x!, (index) => List.filled(y!, 0));
      emit(RowState());
    } else {
      intializeTheMaze();
      emit(RowErrorState());
    }
  }

  void changeColumn(value) {
    y = int.tryParse(value) ?? 1;
    if (x != null && y != null) {
      maze = List.generate(x!, (index) => List.filled(y!, 0));
      emit(ColumnState());
    } else {
      intializeTheMaze();
      emit(ColumnErrorState());
    }
  }

  // to change the start and end point you need to return the old end and start to the normal state
  // ensure that both row and column fields are valid
  void changeStart(){
    //check not null and not exceed the maze size
    if(SR != null && SC != null){
      if(SR < maze.length && SC < maze[0].length) {
        startRow = SR;
        startColumn = SC;
        emit(StartState());
      }
    }
  }
  void changeEnd() {
    if (ER != null && EC != null) {
      if (ER < maze.length && EC < maze[0].length) {
        endRow = ER;
        endColumn = EC;
        emit(EndState());
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

  void toggleCell(int row, int col) {
    if (maze[row][col] == 0) {
      maze[row][col] = 1; // Toggle from white to black
    } else {
      maze[row][col] = 0; // Toggle from black to white
    }
    emit(CellToggledState());
  }

  //============================= solve by BFS ==================
  void search_BFS(){

  }
  //============================= solve by DFS ==================

  //============================= solve by A* ==================
}
