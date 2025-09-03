part of 'categories_bloc.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();
}

final class CategoriesInitial extends CategoriesState {
  @override
  List<Object> get props => [];
}

final class CategoriesLoading extends CategoriesState {
  @override
  List<Object> get props => [];
}

final class CategoriesSuccess extends CategoriesState {
  final List<CategoryEntity> categories;

  const CategoriesSuccess({required this.categories});
  @override
  List<Object> get props => [];
}
