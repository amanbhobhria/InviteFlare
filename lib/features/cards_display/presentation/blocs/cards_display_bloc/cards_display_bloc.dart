import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/features/cards_display/domain/domain.dart';
part 'cards_display_event.dart';
part 'cards_display_state.dart';

@injectable
class CardsDisplayBloc extends Bloc<CardsDisplayEvent, CardsDisplayState> {
  final SubcategoriesAndFilterUseCase subcategoriesAndFilterUseCase;

  CardsDisplayBloc({
    required this.subcategoriesAndFilterUseCase,
  }) : super(CardsDisplayInitial()) {
    on<OnCardsDisplayEvent>(onCardsDisplayEvent);
  }

  FutureOr<void> onCardsDisplayEvent(
    OnCardsDisplayEvent event,
    Emitter<CardsDisplayState> emit,
  ) async {
    try {
      emit(CardsDisplayLoading());
      final subcategoriesAndFilterEntity = await subcategoriesAndFilterUseCase(
          NoParams(categoryName: event.categoryName.toLowerCase()));
      emit(CardsDisplayLoaded(subcategoriesAndFilterEntity));
    } catch (error) {
      emit(CardsDisplayFailure(error: error.toString()));
    }
  }
}
