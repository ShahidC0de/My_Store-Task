import 'package:task/features/home/domain/entities/category.dart';

class CategoryModel extends Categgory {
  CategoryModel(
    super.slug,
    super.name,
    super.url,
  );
  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
      map['slug'] ?? '',
      map['name'] ?? '',
      map['url'] ?? '',
    );
  }
}
