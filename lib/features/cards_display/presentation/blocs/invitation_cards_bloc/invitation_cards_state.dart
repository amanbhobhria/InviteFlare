part of 'invitation_cards_bloc.dart';

sealed class InvitationCardsState extends Equatable {
  const InvitationCardsState();
}

final class InvitationCardsInitial extends InvitationCardsState {
  @override
  List<Object> get props => [];
}

final class InvitationCardsLoading extends InvitationCardsState {
  @override
  List<Object> get props => [];
}

final class InvitationCardsSuccess extends InvitationCardsState {
  final List<Data> invitationCards;
  final List<SubCategoryEntity> subcategories;

  const InvitationCardsSuccess({
    required this.invitationCards,
    required this.subcategories,
  });

  @override
  List<Object?> get props => [invitationCards, subcategories];
}

final class InvitationCardsFailure extends InvitationCardsState {
  final String error;

  const InvitationCardsFailure({required this.error});

  @override
  List<Object?> get props => [];
}
