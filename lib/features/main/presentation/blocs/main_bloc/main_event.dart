part of 'main_bloc.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();
}

class MainUpdatePageEvent extends MainEvent {
  final int pageNo;

  const MainUpdatePageEvent({required this.pageNo});

  @override
  List<Object?> get props => [pageNo];
}
