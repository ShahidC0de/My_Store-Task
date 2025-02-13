import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:task/features/home/data/models/hive_product_model.dart';

abstract interface class LocalDatasource {
  Future<void> storeFavoriteProduct(HiveProductModel product);
  Future<List<HiveProductModel>> getFavoriteProducts();
}

class LocalDataSourceImp implements LocalDatasource {
  final Box<HiveProductModel> _box;
  LocalDataSourceImp({required Box<HiveProductModel> box}) : _box = box;

  @override
  Future<void> storeFavoriteProduct(HiveProductModel product) async {
    try {
      if (_box.containsKey(product.id)) {
        await _box.delete(product.id);
      } else {
        await _box.put(product.id, product);
      }
    } catch (e) {
      log(e.toString());
      throw Exception("Error storing favorite product: ${e.toString()}");
    }
  }

  @override
  Future<List<HiveProductModel>> getFavoriteProducts() async {
    try {
      log(_box.values.length.toString());
      return _box.values.toList();
    } catch (e) {
      throw Exception(
          "Error occurred while getting favorite products: ${e.toString()}");
    }
  }
}
