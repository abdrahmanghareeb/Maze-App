import 'package:ai_maze_project/Home%20layout.dart';
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
  var rowsControllers  = TextEditingController();
  var columnsControllers  = TextEditingController();
  var startRowControllers  = TextEditingController();
  var startColumnControllers  = TextEditingController();
  var endRowControllers  = TextEditingController();
  var endColumnControllers  = TextEditingController();
  //to transform the controllers to int
  int? x ;
  int? y ;
  var maze ;
  // will carry the coordinates of start cell ( row , column ) => ( y, x )
  List<int> start = [0, 0]; // Initialize start point
  List<int> end = [4, 4];

  void intializeTheMaze(){
    maze = List.generate(6, (index) => List.filled(6, 0));
    selectedAlgorithm = algorithmsList.first;
    selectedMode =  modeList.first;
    emit(IntializeMazeState());
  }
  void changeAlgorithm(value){
    selectedAlgorithm = value;
    emit(AlgorithmsState());
  }
  void changeMode(value){
     selectedMode = value;
     emit(ModeState());
  }
  void changeRow(value){
    x = int.tryParse(value) ?? 1;
    if (x != null && y != null) {
      maze = List.generate(x!, (index) => List.filled(y!, 0));
      emit(RowState());
    } else {
      intializeTheMaze();
      emit(RowErrorState());
    }
  }
  void changeColumn(value){
    y = int.tryParse(value) ?? 1;
    if (x != null && y != null) {
      maze = List.generate(x!, (index) => List.filled(y!, 0));
      emit(ColumnState());
    } else {
      intializeTheMaze();
      emit(ColumnErrorState());
    }
  }
  //to change the maze start point
  void changeStartRow(value){
    start[0] = int.tryParse(value) ?? 1;
    emit(StartCellRowState());
  }
  void changeStartColumn(value){
    start[1] = int.tryParse(value) ?? 1;
    emit(StartCellColumnState());
  }
  //to change the maze end point
  void changeEndRow(value){
    end[0] = int.tryParse(value) ?? 1;
    emit(EndCellRowState());
  }
  void changeEndColumn(value){
    end[1] = int.tryParse(value) ?? 1;
    emit(EndCellColumnState());
  }
  //toggle the cell between (white and black) color when the
  void changeOnCellClick(){
    emit(OnCellClickState());
  }
}
