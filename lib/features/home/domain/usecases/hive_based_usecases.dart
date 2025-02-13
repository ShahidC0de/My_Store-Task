import 'package:fpdart/fpdart.dart';
import 'package:task/core/failure/failure.dart';
import 'package:task/core/usecase/usecase.dart';
import 'package:task/features/home/domain/entities/hive_product.dart';
import 'package:task/features/home/domain/repositories/repository.dart';

// Storing
class StoreFavoriteProductUsecase
    implements Usecase<void, FavoriteProductParams> {
  final HomeRepository _homeRepository;
  StoreFavoriteProductUsecase({
    required HomeRepository homeRepository,
  }) : _homeRepository = homeRepository;
  @override
  Future<Either<Failure, void>> call(FavoriteProductParams params) async {
    return _homeRepository.storeFavoriteProduct(params.productId);
  }
}

class FavoriteProductParams {
  final HiveProduct productId;
  FavoriteProductParams(this.productId);
}

// Fetching
class FetchFavoriteProductsUsecase
    implements Usecase<List<HiveProduct>, NoParams> {
  final HomeRepository _homeRepository;
  FetchFavoriteProductsUsecase({
    required HomeRepository homeRepository,
  }) : _homeRepository = homeRepository;
  @override
  Future<Either<Failure, List<HiveProduct>>> call(NoParams params) async {
    return _homeRepository.fetchFavoriteProducts();
  }
}
