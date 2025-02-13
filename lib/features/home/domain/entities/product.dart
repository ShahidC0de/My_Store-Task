import 'package:task/features/home/data/models/product_model.dart';

class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final double weight;
  final Dimensions dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<Review> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final Meta meta;
  final List<String> images;
  final String thumbnail;
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  // ✅ Add an empty constructor
  factory Product.empty() {
    return Product(
      id: 0,
      title: '',
      description: '',
      category: '',
      price: 0.0,
      discountPercentage: 0.0,
      rating: 0.0,
      stock: 0,
      tags: [],
      brand: '',
      sku: '',
      weight: 0.0,
      dimensions: Dimensions.empty(),
      warrantyInformation: '',
      shippingInformation: '',
      availabilityStatus: '',
      reviews: [],
      returnPolicy: '',
      minimumOrderQuantity: 0,
      meta: Meta.empty(),
      images: [],
      thumbnail: '',
    );
  }
}
