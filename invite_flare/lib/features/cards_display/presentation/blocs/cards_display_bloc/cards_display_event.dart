part of 'cards_display_bloc.dart';

sealed class CardsDisplayEvent extends Equatable {
  const CardsDisplayEvent();
}

final class OnCardsDisplayEvent extends CardsDisplayEvent {
  final String categoryName;

  const OnCardsDisplayEvent({required this.categoryName});

  @override
  List<Object> get props => [];
}
