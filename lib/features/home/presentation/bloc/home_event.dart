part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class FetchAllProductsEvent extends HomeEvent {}

class FetchAllCategoriesEvent extends HomeEvent {}

class FetchProductsBasedOnProductsEvent extends HomeEvent {
  final String query;
  FetchProductsBasedOnProductsEvent({
    required this.query,
  });
}

class FetchFavoriteProductsEvent extends HomeEvent {}

class StoreFavoriteProductEvent extends HomeEvent {
  final HiveProduct product;
  StoreFavoriteProductEvent({
    required this.product,
  });
}
