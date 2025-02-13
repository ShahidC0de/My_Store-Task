part of 'home_bloc.dart';

@immutable
class HomeState {
  final List<Product> products;
  final List<HiveProduct> favoriteProducts;

  final bool isLoading;
  final String? errorMessage;
  final List<Categgory> categories;
  final List<Product> categoryBasedProducts;
  const HomeState({
    required this.favoriteProducts,
    required this.products,
    required this.isLoading,
    this.errorMessage,
    required this.categories,
    required this.categoryBasedProducts,
  });
  HomeState copyWith({
    List<HiveProduct>? favoriteProducts,
    List<Product>? products,
    bool? isLoading,
    String? errorMessage,
    List<Categgory>? categories,
    List<Product>? categoryBasedProducts,
  }) {
    return HomeState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      categories: categories ?? this.categories,
      categoryBasedProducts:
          categoryBasedProducts ?? this.categoryBasedProducts,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
    );
  }
}

final class HomeInitial extends HomeState {
  const HomeInitial()
      : super(
          products: const [],
          isLoading: false,
          favoriteProducts: const [],
          categories: const [],
          categoryBasedProducts: const [],
        );
}
