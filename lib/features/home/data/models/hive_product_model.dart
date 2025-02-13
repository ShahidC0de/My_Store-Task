import 'package:hive/hive.dart';
import 'package:task/features/home/domain/entities/hive_product.dart';

part 'hive_product_model.g.dart';

@HiveType(typeId: 1)
class HiveProductModel {
  @HiveField(0)
  final int id;

  HiveProductModel({required this.id});
  List<HiveProduct> convertToHiveProductList(List<HiveProductModel> models) {
    return models.map((model) => HiveProduct(id: model.id)).toList();
  }
}
