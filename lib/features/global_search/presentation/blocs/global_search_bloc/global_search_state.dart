part of 'global_search_bloc.dart';

sealed class GlobalSearchState extends Equatable {
  const GlobalSearchState();
}

final class GlobalSearchInitial extends GlobalSearchState {
  @override
  List<Object> get props => [];
}

final class GlobalSearchLoading extends GlobalSearchState {
  @override
  List<Object> get props => [];
}

final class GlobalSearchSuccess extends GlobalSearchState {
  final List<Data> invitationCards;

  const GlobalSearchSuccess({required this.invitationCards});

  @override
  List<Object> get props => [invitationCards];
}

final class GlobalSearchError extends GlobalSearchState {
  final String error;

  const GlobalSearchError({required this.error});

  @override
  List<Object> get props => [];
}
