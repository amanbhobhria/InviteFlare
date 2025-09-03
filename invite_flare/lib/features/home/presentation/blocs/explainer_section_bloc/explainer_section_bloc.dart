import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/core/mock/mock_data.dart';

part 'explainer_section_event.dart';
part 'explainer_section_state.dart';

@injectable
class ExplainerSectionBloc
    extends Bloc<ExplainerSectionEvent, ExplainerSectionState> {
  ExplainerSectionBloc() : super(ExplainerSectionInitial()) {
    on<FetchExplainerSectionEvent>(getExplainerSectionMethod);
  }

  FutureOr<void> getExplainerSectionMethod(
    FetchExplainerSectionEvent event,
    Emitter<ExplainerSectionState> emit,
  ) async {
    emit(ExplainerSectionLoadingState());
    emit(
      ExplainerSectionSuccessState(
        explainerSection: MockData.explainerSection,
      ),
    );
  }
}
