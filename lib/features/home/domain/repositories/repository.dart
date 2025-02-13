import 'package:fpdart/fpdart.dart';
import 'package:task/core/failure/failure.dart';
import 'package:task/features/home/data/models/product_model.dart';
import 'package:task/features/home/domain/entities/category.dart';
import 'package:task/features/home/domain/entities/hive_product.dart';
import 'package:task/features/home/domain/entities/product.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<Product>>> fetchAllProducts();
  Future<Either<Failure, List<Categgory>>> fetchAllCategories();
  Future<Either<Failure, List<ProductModel>>> fetchProductsBasedOnCategory(
      String categoryName);
  Future<Either<Failure, void>> storeFavoriteProduct(HiveProduct product);
  Future<Either<Failure, List<HiveProduct>>> fetchFavoriteProducts();
}
