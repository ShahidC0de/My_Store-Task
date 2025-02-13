import 'package:fpdart/fpdart.dart';
import 'package:task/core/failure/failure.dart';
import 'package:task/core/usecase/usecase.dart';
import 'package:task/features/home/domain/entities/category.dart';
import 'package:task/features/home/domain/repositories/repository.dart';

class FetchAllCategories implements Usecase<List<Categgory>, NoParams> {
  final HomeRepository _homeRepository;
  FetchAllCategories({
    required HomeRepository homeRepository,
  }) : _homeRepository = homeRepository;
  @override
  Future<Either<Failure, List<Categgory>>> call(NoParams params) async {
    return _homeRepository.fetchAllCategories();
  }
}
