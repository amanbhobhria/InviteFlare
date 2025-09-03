part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();
}

final class FetchCategoryEvent extends CategoryEvent {
  @override
  List<Object?> get props => [];
}
