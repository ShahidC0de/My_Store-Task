import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/usecase/usecase.dart';
import 'package:task/features/home/domain/entities/category.dart';
import 'package:task/features/home/domain/entities/hive_product.dart';
import 'package:task/features/home/domain/entities/product.dart';
import 'package:task/features/home/domain/usecases/fetch_all_categories.dart';
import 'package:task/features/home/domain/usecases/fetch_all_products.dart';
import 'package:task/features/home/domain/usecases/fetch_product_on_category.dart';
import 'package:task/features/home/domain/usecases/hive_based_usecases.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final StoreFavoriteProductUsecase _storeFavoriteProductUsecase;
  final FetchFavoriteProductsUsecase _fetchFavoriteProductsUsecase;
  final FetchAllProducts _fetchAllProducstUsecase;
  final FetchAllCategories _fetchAllCategories;
  final FetchProductOnCategory _fetchProductOnCategory;
  HomeBloc({
    required StoreFavoriteProductUsecase storeFavoriteProductUsecase,
    required FetchFavoriteProductsUsecase fetchFavoriteProductsUsecase,
    required FetchAllCategories fetchAllCategories,
    required FetchAllProducts fetchAllProductsUsecase,
    required FetchProductOnCategory fetchProductOnCategory,
  })  : _fetchAllProducstUsecase = fetchAllProductsUsecase,
        _fetchAllCategories = fetchAllCategories,
        _fetchProductOnCategory = fetchProductOnCategory,
        _fetchFavoriteProductsUsecase = fetchFavoriteProductsUsecase,
        _storeFavoriteProductUsecase = storeFavoriteProductUsecase,
        super(HomeInitial()) {
    on<FetchAllProductsEvent>(_fetchAllproducts);
    on<FetchAllCategoriesEvent>(_fetchAllCategoriesF);
    on<FetchProductsBasedOnProductsEvent>(_fetchProductsOnCategoryBased);
    on<StoreFavoriteProductEvent>(_storeFavoriteProduct);
    on<FetchFavoriteProductsEvent>(_fetchFavoriteListOfProducts);
  }
  Future<void> _fetchProductsOnCategoryBased(
      FetchProductsBasedOnProductsEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await _fetchProductOnCategory
          .call(CategoryParams(categoryName: event.query));

      response.fold((failure) {
        emit(state.copyWith(errorMessage: failure.message, isLoading: false));
      }, (success) {
        emit(state.copyWith(
          categoryBasedProducts: success,
          isLoading: false,
        ));
      });
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  Future<void> _fetchAllproducts(
      FetchAllProductsEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await _fetchAllProducstUsecase.call(NoParams());

      response.fold((failure) {
        emit(state.copyWith(errorMessage: failure.message, isLoading: false));
      }, (success) {
        emit(state.copyWith(
          products: success,
          isLoading: false,
        ));
      });
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  Future<void> _fetchAllCategoriesF(
      FetchAllCategoriesEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await _fetchAllCategories.call(NoParams());
      response.fold((failure) {
        emit(state.copyWith(errorMessage: failure.message, isLoading: false));
      }, (success) {
        emit(state.copyWith(
          categories: success,
          isLoading: false,
        ));
      });
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  Future<void> _fetchFavoriteListOfProducts(
      FetchFavoriteProductsEvent event, Emitter<HomeState> emit) async {
    try {
      final response = await _fetchFavoriteProductsUsecase.call(NoParams());
      response.fold((failure) {
        emit(state.copyWith(errorMessage: failure.message));
      }, (success) {
        emit(state.copyWith(favoriteProducts: success));
      });
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _storeFavoriteProduct(
      StoreFavoriteProductEvent event, Emitter<HomeState> emit) async {
    try {
      final response = await _storeFavoriteProductUsecase
          .call(FavoriteProductParams(event.product));

      response.fold((failure) {
        emit(state.copyWith(errorMessage: failure.message));
      }, (success) async {
        log('Successfully updated favorite list');

        final updatedFavorites = List<HiveProduct>.from(state.favoriteProducts);
        final isFavorite =
            updatedFavorites.any((fav) => fav.id == event.product.id);

        if (isFavorite) {
          updatedFavorites.removeWhere((fav) => fav.id == event.product.id);
        } else {
          updatedFavorites.add(event.product);
        }

        emit(state.copyWith(favoriteProducts: updatedFavorites));

        add(FetchFavoriteProductsEvent());
      });
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
