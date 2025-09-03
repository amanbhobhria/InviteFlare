part of 'invitation_cards_bloc.dart';

sealed class InvitationCardsEvent extends Equatable {
  const InvitationCardsEvent();
}

class OnInvitationCardsLoadEvent extends InvitationCardsEvent {
  final List<SubCategoryEntity> subcategories;
  final String categoryName;

  const OnInvitationCardsLoadEvent(
      {required this.subcategories, required this.categoryName});

  @override
  List<Object?> get props => [subcategories];
}
