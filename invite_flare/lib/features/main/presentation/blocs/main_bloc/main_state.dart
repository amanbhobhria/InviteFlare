part of 'main_bloc.dart';

sealed class MainState extends Equatable {
  const MainState();
}

final class MainInitial extends MainState {
  @override
  List<Object> get props => [];
}

final class MainLoadingState extends MainState {
  @override
  List<Object> get props => [];
}

final class MainUpdateState extends MainState {
  final int pageNo;

  const MainUpdateState({required this.pageNo});
  @override
  List<Object> get props => [pageNo];
}
