import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task/features/home/data/data_source/home_remote_data_source.dart';
import 'package:task/features/home/data/data_source/local_data_source.dart';
import 'package:task/features/home/data/models/hive_product_model.dart';
import 'package:task/features/home/data/repository_impl.dart/home_repository_impl.dart';
import 'package:task/features/home/domain/repositories/repository.dart';
import 'package:task/features/home/domain/usecases/fetch_all_categories.dart';
import 'package:task/features/home/domain/usecases/fetch_all_products.dart';
import 'package:task/features/home/domain/usecases/fetch_product_on_category.dart';
import 'package:task/features/home/domain/usecases/hive_based_usecases.dart';
import 'package:task/features/home/presentation/bloc/home_bloc.dart';

final serviceLoctor = GetIt.instance;
void initHome() {
  final Dio dio = Dio();

  try {
    //remote data source
    serviceLoctor.registerFactory<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(dio: dio));
    serviceLoctor.registerFactory<HomeRepository>(() => HomeRepositoryImpl(
        homeRemoteDataSource: serviceLoctor(),
        localDataSource: serviceLoctor()));
    serviceLoctor.registerFactory(
        () => FetchAllProducts(homeRepository: serviceLoctor()));
    serviceLoctor.registerFactory(
        () => FetchAllCategories(homeRepository: serviceLoctor()));
    serviceLoctor.registerFactory(
        () => FetchProductOnCategory(homeRepository: serviceLoctor()));
    serviceLoctor.registerLazySingleton(() => HomeBloc(
        fetchFavoriteProductsUsecase: serviceLoctor(),
        storeFavoriteProductUsecase: serviceLoctor(),
        fetchProductOnCategory: serviceLoctor(),
        fetchAllProductsUsecase: serviceLoctor(),
        fetchAllCategories: serviceLoctor()));
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<void> initHive() async {
  try {
    final appDir = await getApplicationDocumentsDirectory();
    Hive.init(appDir.path);

    // Register the adapter
    Hive.registerAdapter(HiveProductModelAdapter());

    // Open the Hive box
    final favoriteBox = await Hive.openBox<HiveProductModel>('favorites');

    // Register the box with the correct type
    serviceLoctor
        .registerLazySingleton<Box<HiveProductModel>>(() => favoriteBox);

    // Register LocalDatasource correctly
    serviceLoctor.registerFactory<LocalDatasource>(
        () => LocalDataSourceImp(box: serviceLoctor()));

    // Register use cases
    serviceLoctor.registerFactory(
        () => FetchFavoriteProductsUsecase(homeRepository: serviceLoctor()));
    serviceLoctor.registerFactory(
        () => StoreFavoriteProductUsecase(homeRepository: serviceLoctor()));
  } catch (e) {
    throw Exception("Hive Initialization Error: ${e.toString()}");
  }
}
