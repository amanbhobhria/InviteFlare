part of 'card_details_bloc.dart';

sealed class CardDetailsState extends Equatable {
  const CardDetailsState();
}

final class CardDetailsInitial extends CardDetailsState {
  @override
  List<Object> get props => [];
}
