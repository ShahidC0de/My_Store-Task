class DataQueries {
  static const String fetchAllProductQuery = 'https://dummyjson.com/products';
  static const String fetchAllCategories =
      'https://dummyjson.com/products/categories';
  static String fetchProductsOnCategoryBased(String name) {
    return 'https://dummyjson.com/products/$name';
  }
}
