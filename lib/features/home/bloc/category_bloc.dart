import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:matule/features/home/data/models/category.dart';
import 'package:matule/features/home/data/repositories/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({required this.categoryRepository}) : super(CategoryInitial()) {
    on<LoadCategory>(_load);
  }

  final CategoryRepository categoryRepository;

  Future<void> _load(event, emit) async {
    try {
      if (state is! CategoryLoaded) {
        emit(CategoryLoading());
      }
      final categories = await categoryRepository.getCategories();
      emit(CategoryLoaded(categories: categories));
    } catch (e) {
      emit(CategoryLoadingFailure(exception: e));
    }
  }
}
