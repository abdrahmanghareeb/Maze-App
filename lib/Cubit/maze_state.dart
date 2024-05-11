part of 'maze_cubit.dart';

@immutable
sealed class MazeState {}

final class MazeInitial extends MazeState {}

final class IntializeMazeState extends MazeState {}

final class AlgorithmsState extends MazeState {}
final class ModeState extends MazeState {}

final class RowState extends MazeState {}
final class ColumnState extends MazeState {}
final class ColumnErrorState extends MazeState {}
final class RowErrorState extends MazeState {}

final class StartCellColumnState extends MazeState {}
final class EndCellColumnState extends MazeState {}
final class StartCellRowState extends MazeState {}
final class EndCellRowState extends MazeState {}
final class StartState extends MazeState {}
final class EndState extends MazeState {}

final class OnCellClickState extends MazeState {}
final class CellToggledState extends MazeState {}

final class search_State extends MazeState {}
final class changeMazeValues_State extends MazeState {}



