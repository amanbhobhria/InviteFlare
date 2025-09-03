import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/features/global_search/global_search.dart';
import 'package:invite_flare/shared/shared.dart';

part 'global_search_event.dart';
part 'global_search_state.dart';

@Injectable()
class GlobalSearchBloc extends Bloc<GlobalSearchEvent, GlobalSearchState> {
  final SearchInvitationCardUseCase searchInvitationCardUseCase;

  GlobalSearchBloc({
    required this.searchInvitationCardUseCase,
  }) : super(GlobalSearchInitial()) {
    on<OnGlobalSearchInitEvent>(onInitialEvent);
    on<OnGlobalSearchCardsEvent>(onSearchCardEvent);
  }

  FutureOr<void> onInitialEvent(
    OnGlobalSearchInitEvent event,
    Emitter<GlobalSearchState> emit,
  ) {
    emit(const GlobalSearchError(error: ''));
  }

  FutureOr<void> onSearchCardEvent(
    OnGlobalSearchCardsEvent event,
    Emitter<GlobalSearchState> emit,
  ) async {
    log('onSearchCardEvent : ${event.searchText}');
    if (event.searchText.isNotEmpty && event.searchText.length >= 3) {
      emit(GlobalSearchLoading());
      final invitationCards =
          await searchInvitationCardUseCase(event.searchText);
      emit(GlobalSearchSuccess(invitationCards: invitationCards));
    } else {
      emit(const GlobalSearchError(error: 'Enter at least 3 characters'));
    }
  }
}
