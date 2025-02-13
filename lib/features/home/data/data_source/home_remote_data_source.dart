import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:task/core/data_queries/data_queries.dart';
import 'package:task/features/home/data/models/category_model/category_model.dart';
import 'package:task/features/home/data/models/product_model.dart';

abstract interface class HomeRemoteDataSource {
  Future<List<ProductModel>> fetchAllProducts();
  Future<List<CategoryModel>> fetchAllCategories();
  Future<List<ProductModel>> fetchSpecificCategoryBasedProducts(
      String categoryName);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio _dio;
  HomeRemoteDataSourceImpl({
    required Dio dio,
  }) : _dio = dio;
  @override
  Future<List<ProductModel>> fetchAllProducts() async {
    try {
      final response = await _dio.get(DataQueries.fetchAllProductQuery);
      final List<dynamic> rawData = response.data['products'];
      log(rawData.length.toString());
      return rawData.map((product) => ProductModel.fromJson(product)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<CategoryModel>> fetchAllCategories() async {
    try {
      final response = await _dio.get(DataQueries.fetchAllCategories);
      final List<dynamic> rawData = response.data;
      log(rawData.length.toString());
      return rawData
          .map((category) => CategoryModel.fromJson(category))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> fetchSpecificCategoryBasedProducts(
      String categoryName) async {
    try {
      // Correct API URL
      final response = await _dio.get(
        'https://dummyjson.com/products/category/${categoryName.toLowerCase()}',
      );

      // Ensure response structure is correct
      final List<dynamic> rawData = response.data['products'];

      log("Total products fetched: ${rawData.length}");

      // Convert raw data to ProductModel list
      return rawData.map((product) => ProductModel.fromJson(product)).toList();
    } catch (e) {
      log("Error: $e");
      throw Exception(e.toString());
    }
  }
}
