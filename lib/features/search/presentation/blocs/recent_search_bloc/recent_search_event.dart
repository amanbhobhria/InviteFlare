part of 'recent_search_bloc.dart';

sealed class RecentSearchEvent extends Equatable {
  const RecentSearchEvent();
}

final class GetRecentSearchEvent extends RecentSearchEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
