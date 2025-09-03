part of 'recent_search_bloc.dart';

sealed class RecentSearchState extends Equatable {
  const RecentSearchState();
}

final class RecentSearchInitial extends RecentSearchState {
  @override
  List<Object> get props => [];
}

final class RecentSearchLoading extends RecentSearchState {
  @override
  List<Object> get props => [];
}

final class RecentSearchSuccess extends RecentSearchState {
  @override
  List<Object> get props => [];
}

final class RecentSearchError extends RecentSearchState {
  @override
  List<Object> get props => [];
}
