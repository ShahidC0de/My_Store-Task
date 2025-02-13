import 'package:task/features/home/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.price,
    required super.discountPercentage,
    required super.rating,
    required super.stock,
    required super.tags,
    required super.brand,
    required super.sku,
    required super.weight,
    required super.dimensions,
    required super.warrantyInformation,
    required super.shippingInformation,
    required super.availabilityStatus,
    required super.reviews,
    required super.returnPolicy,
    required super.minimumOrderQuantity,
    required super.meta,
    required super.images,
    required super.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] ?? 'Unknown',
      description: json['description'] ?? 'No description available',
      category: json['category'] ?? 'Unknown',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] as int? ?? 0, // Keep as int
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
              [],
      brand: json['brand'] ?? 'No brand',
      sku: json['sku'] ?? 'No SKU',
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      dimensions: json['dimensions'] != null
          ? Dimensions.fromJson(json['dimensions'])
          : Dimensions(width: 0.0, height: 0.0, depth: 0.0),
      warrantyInformation:
          json['warrantyInformation'] ?? 'No warranty information',
      shippingInformation:
          json['shippingInformation'] ?? 'No shipping information',
      availabilityStatus: json['availabilityStatus'] ?? 'Unknown',
      reviews: (json['reviews'] as List<dynamic>?)
              ?.map((e) => Review.fromJson(e))
              .toList() ??
          [],
      returnPolicy: json['returnPolicy'] ?? 'No return policy',
      minimumOrderQuantity: json['minimumOrderQuantity'] as int? ?? 1,
      meta: json['meta'] != null
          ? Meta.fromJson(json['meta'])
          : Meta(createdAt: 'Unknown', updatedAt: 'Unknown'),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      thumbnail: json['thumbnail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'sku': sku,
      'weight': weight,
      'dimensions': dimensions.toJson(),
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'reviews': reviews.map((e) => e.toJson()).toList(),
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'meta': meta.toJson(),
      'images': images,
      'thumbnail': thumbnail,
    };
  }
}

class Dimensions {
  final double width;
  final double height;
  final double depth;

  Dimensions({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      width: (json['width'] as num?)?.toDouble() ?? 0.0,
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
      depth: (json['depth'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'depth': depth,
    };
  }

  factory Dimensions.empty() {
    return Dimensions(height: 0.0, width: 0.0, depth: 0.0);
  }
}

class Review {
  final String user;
  final String comment;
  final double rating;

  Review({
    required this.user,
    required this.comment,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      user: json['reviewerName'] ?? 'Anonymous', // Fix: Use correct field name
      comment: json['comment'] ?? 'No comment',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'comment': comment,
      'rating': rating,
    };
  }
}

class Meta {
  final String createdAt;
  final String updatedAt;

  Meta({
    required this.createdAt,
    required this.updatedAt,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      createdAt: json['createdAt'] ?? 'Unknown',
      updatedAt: json['updatedAt'] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Meta.empty() {
    return Meta(createdAt: '', updatedAt: '');
  }
}
