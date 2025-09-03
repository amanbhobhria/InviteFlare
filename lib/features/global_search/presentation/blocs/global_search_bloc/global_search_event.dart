part of 'global_search_bloc.dart';

sealed class GlobalSearchEvent extends Equatable {
  const GlobalSearchEvent();
}

final class OnGlobalSearchInitEvent extends GlobalSearchEvent {
  @override
  List<Object?> get props => [];
}

final class OnGlobalSearchCardsEvent extends GlobalSearchEvent {
  final String searchText;

  const OnGlobalSearchCardsEvent({required this.searchText});
  @override
  List<Object?> get props => [searchText];
}
