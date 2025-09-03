part of 'cards_display_bloc.dart';

sealed class CardsDisplayState extends Equatable {
  const CardsDisplayState();
}

final class CardsDisplayInitial extends CardsDisplayState {
  @override
  List<Object> get props => [];
}

final class CardsDisplayLoading extends CardsDisplayState {
  @override
  List<Object> get props => [];
}

final class CardsDisplayLoaded extends CardsDisplayState {
  final SubcategoriesAndFilterEntity subcategoriesAndFilterEntity;

  const CardsDisplayLoaded(this.subcategoriesAndFilterEntity);

  @override
  List<Object> get props => [subcategoriesAndFilterEntity];
}

final class CardsDisplayFailure extends CardsDisplayState {
  final String error;

  const CardsDisplayFailure({required this.error});

  @override
  List<Object?> get props => [];
}
