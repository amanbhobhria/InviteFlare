import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/features/cards_display/domain/domain.dart';
import 'package:invite_flare/shared/domain/entities/invitation_card_entity.dart';

part 'invitation_cards_event.dart';
part 'invitation_cards_state.dart';

@injectable
class InvitationCardsBloc
    extends Bloc<InvitationCardsEvent, InvitationCardsState> {
  final  invitationCardsUseCase;//InvitationCardsUseCase

  InvitationCardsBloc({required this.invitationCardsUseCase})
      : super(InvitationCardsInitial()) {
    on<OnInvitationCardsLoadEvent>(onInvitationCardsLoad);
  }

  FutureOr<void> onInvitationCardsLoad(
    OnInvitationCardsLoadEvent event,
    Emitter<InvitationCardsState> emit,
  ) async {
    try {
      emit(InvitationCardsLoading());
      final invitationCards = await invitationCardsUseCase(
          NoParams(categoryName: event.categoryName));
      if (invitationCards.isNotEmpty) {
        emit(InvitationCardsSuccess(
            invitationCards: invitationCards,
            subcategories: event.subcategories));
      } else {
        emit(const InvitationCardsFailure(error: 'No Categories'));
      }
    } catch (error) {
      emit(InvitationCardsFailure(error: error.toString()));
    }
  }
}
