import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/core/mock/mock_data.dart';

part 'expandable_card_event.dart';
part 'expandable_card_state.dart';

@injectable
class ExpandableCardBloc
    extends Bloc<ExpandableCardEvent, ExpandableCardState> {
  ExpandableCardBloc() : super(ExpandableCardInitial()) {
    on<FetchExpandableCardEvent>(getExpandableCardsMethod);
  }

  FutureOr<void> getExpandableCardsMethod(
    FetchExpandableCardEvent event,
    Emitter<ExpandableCardState> emit,
  ) async {
    emit(ExpandableCardLoadingState());
    emit(
      ExpandableCardSuccessState(
        expandableCard: MockData.expandableBirthday,
      ),
    );
  }
}
