import 'package:fpdart/fpdart.dart';
import 'package:task/core/failure/failure.dart';
import 'package:task/core/usecase/usecase.dart';
import 'package:task/features/home/domain/entities/product.dart';
import 'package:task/features/home/domain/repositories/repository.dart';

class FetchAllProducts implements Usecase<List<Product>, NoParams> {
  final HomeRepository _homeRepository;
  FetchAllProducts({required HomeRepository homeRepository})
      : _homeRepository = homeRepository;
  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return _homeRepository.fetchAllProducts();
  }
}
