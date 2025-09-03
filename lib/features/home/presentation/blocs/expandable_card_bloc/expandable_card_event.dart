part of 'expandable_card_bloc.dart';

sealed class ExpandableCardEvent extends Equatable {
  const ExpandableCardEvent();
}

final class FetchExpandableCardEvent extends ExpandableCardEvent {
  @override
  List<Object?> get props => [];
}
