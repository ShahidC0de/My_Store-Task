import 'package:fpdart/fpdart.dart';
import 'package:task/core/failure/failure.dart';
import 'package:task/core/usecase/usecase.dart';
import 'package:task/features/home/domain/entities/product.dart';
import 'package:task/features/home/domain/repositories/repository.dart';

class FetchProductOnCategory implements Usecase<List<Product>, CategoryParams> {
  final HomeRepository _homeRepository;
  FetchProductOnCategory({
    required HomeRepository homeRepository,
  }) : _homeRepository = homeRepository;
  @override
  Future<Either<Failure, List<Product>>> call(CategoryParams params) async {
    return _homeRepository.fetchProductsBasedOnCategory(params.categoryName);
  }
}

class CategoryParams {
  final String categoryName;
  CategoryParams({
    required this.categoryName,
  });
}
