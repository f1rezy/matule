import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:matule/features/home/data/models/category.dart';

class CategoryRepository {
  CategoryRepository({required this.dio});

  final Dio dio;

  Future<List<Category>> getCategories() async {
    final response = await dio.get('/rest/v1/categories?select=*');
    final data = response.data;
    final categories = List<Category>.from(
        data.map((value) => Category.fromMap(value)).toList());
    return categories;
  }
}
