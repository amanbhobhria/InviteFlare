part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();
}

final class CategoryInitial extends CategoryState {
  @override
  List<Object> get props => [];
}

final class CategoryLoadingState extends CategoryState {
  @override
  List<Object> get props => [];
}

final class CategorySuccessState extends CategoryState {
  final List<CategoryEntity> categories;

  const CategorySuccessState(this.categories);
  @override
  List<Object> get props => [];
}

final class CategoryErrorState extends CategoryState {
  @override
  List<Object> get props => [];
}
