import 'package:fpdart/fpdart.dart';
import 'package:task/core/failure/failure.dart';
import 'package:task/features/home/data/data_source/home_remote_data_source.dart';
import 'package:task/features/home/data/data_source/local_data_source.dart';
import 'package:task/features/home/data/models/category_model/custom_utiltity.dart';
import 'package:task/features/home/data/models/hive_product_model.dart';
import 'package:task/features/home/data/models/product_model.dart';
import 'package:task/features/home/domain/entities/category.dart';
import 'package:task/features/home/domain/entities/hive_product.dart';
import 'package:task/features/home/domain/entities/product.dart';
import 'package:task/features/home/domain/repositories/repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final LocalDatasource _localDataSource;
  final HomeRemoteDataSource _homeRemoteDataSource;
  HomeRepositoryImpl({
    required LocalDatasource localDataSource,
    required HomeRemoteDataSource homeRemoteDataSource,
  })  : _homeRemoteDataSource = homeRemoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<Either<Failure, List<Product>>> fetchAllProducts() async {
    try {
      final response = await _homeRemoteDataSource.fetchAllProducts();
      return right(response);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Categgory>>> fetchAllCategories() async {
    try {
      final response = await _homeRemoteDataSource.fetchAllCategories();
      return right(response);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> fetchProductsBasedOnCategory(
      String categoryName) async {
    try {
      final response = await _homeRemoteDataSource
          .fetchSpecificCategoryBasedProducts(categoryName);
      return right(response);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HiveProduct>>> fetchFavoriteProducts() async {
    try {
      final response = await _localDataSource.getFavoriteProducts();
      List<HiveProduct> hiveProducts = convertToHiveProductList(response);
      return right(hiveProducts);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> storeFavoriteProduct(
      HiveProduct product) async {
    try {
      final readyData = HiveProductModel(id: product.id);

      final response = await _localDataSource.storeFavoriteProduct(readyData);
      return right(response);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
