import 'package:task/features/home/data/models/hive_product_model.dart';

class HiveProduct {
  final int id;
  HiveProduct({required this.id});
}

extension HiveProductModelWrapper on HiveProductModel {
  HiveProduct toHiveProduct() {
    return HiveProduct(
      id: id,
    );
  }
}
