import 'package:task/features/home/data/models/hive_product_model.dart';
import 'package:task/features/home/domain/entities/hive_product.dart';

List<HiveProduct> convertToHiveProductList(List<HiveProductModel> models) {
  return models.map((model) => HiveProduct(id: model.id)).toList();
}
