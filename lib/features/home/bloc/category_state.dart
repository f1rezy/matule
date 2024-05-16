part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();
  
  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {
}

final class CategoryLoaded extends CategoryState {
  const CategoryLoaded({
    required this.categories,
  });

  final List<Category> categories;

  @override
  List<Object> get props => [categories];
}

final class CategoryLoadingFailure extends CategoryState {
  const CategoryLoadingFailure({
    required this.exception,
  });

  final Object exception;

  @override
  List<Object> get props => [exception];
}
