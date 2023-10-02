import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String productId;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;

  const Product({
    required this.productId,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      descriptionEn: json['description_en'],
      descriptionAr: json['description_ar'],
    );
  }

  Product coptWith({
    String? productId,
    String? nameEn,
    String? nameAr,
    String? descriptionEn,
    String? descriptionAr,
  }) {
    return Product(
      productId: productId ?? this.productId,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'name_en': nameEn,
      'name_ar': nameAr,
      "description_en": descriptionEn,
      'description_ar': descriptionAr,
    };
  }

  @override
  List<Object?> get props =>
      [productId, nameEn, nameAr, descriptionEn, descriptionAr];
}

class ProductCategory extends Equatable {
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final String categoryId;

  const ProductCategory({
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.categoryId,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      descriptionEn: json['description_en'],
      descriptionAr: json['description_ar'],
      categoryId: json['category_id'],
    );
  }

  factory ProductCategory.initial() {
    return const ProductCategory(
      nameEn: '',
      nameAr: '',
      descriptionEn: '',
      descriptionAr: '',
      categoryId: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name_en': nameEn,
      'name_ar': nameAr,
      'description_en': descriptionEn,
      'description_ar': descriptionAr,
      'category_id': categoryId,
    };
  }

  ProductCategory copyWith({
    String? nameEn,
    String? nameAr,
    String? descriptionEn,
    String? descriptionAr,
    String? categoryId,
  }) {
    return ProductCategory(
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  static List<ProductCategory> list(List<Map<String, dynamic>> list) {
    return list.map((e) => ProductCategory.fromJson(e)).toList();
  }

  @override
  List<Object?> get props =>
      [nameEn, nameAr, descriptionEn, descriptionAr, categoryId];
}

class ProductFeature {
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final String productId;
  final bool hasSpecialValue;
  final String? specialValueType;
  final int? specialValueInt;
  final double? specialValueDouble;
  final bool? specialValueBool;

  ProductFeature({
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.productId,
    required this.hasSpecialValue,
    required this.specialValueType,
    required this.specialValueInt,
    required this.specialValueDouble,
    required this.specialValueBool,
  });
}

class ProductPrice extends Equatable {
  final String productId;
  final double price;
  final double discount;

  const ProductPrice({
    required this.productId,
    required this.price,
    required this.discount,
  });

  factory ProductPrice.fromJson(Map<String, dynamic> json) {
    return ProductPrice(
      productId: json['product_id'],
      price: json['price'],
      discount: json['discount'],
    );
  }

  factory ProductPrice.initial() {
    return const ProductPrice(
      productId: '',
      price: 0.0,
      discount: 0.0,
    );
  }

  ProductPrice copyWith({String? productId, double? price, double? discount}) {
    return ProductPrice(
      productId: productId ?? this.productId,
      price: price ?? this.price,
      discount: discount ?? this.discount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'price': price,
      'discount': discount,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object?> get props => [productId, price, discount];
}

class ProductInventory {
  final String productId;
  final bool available;
  final double amount;
  final String unit;
  final String dateWhenAvailable;

  ProductInventory({
    required this.productId,
    required this.available,
    required this.amount,
    required this.unit,
    required this.dateWhenAvailable,
  });
}

class ProductUnit extends Equatable {
  final String unitId;
  final String nameEn;
  final String nameAr;

  const ProductUnit({
    required this.unitId,
    required this.nameEn,
    required this.nameAr,
  });

  factory ProductUnit.initial() {
    return const ProductUnit(
      unitId: '',
      nameEn: '',
      nameAr: '',
    );
  }

  factory ProductUnit.fromJson(Map<String, dynamic> json) {
    return ProductUnit(
      unitId: json['unit_id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
    );
  }

  ProductUnit copyWith({String? nameEn, String? nameAr, String? unitId}) {
    return ProductUnit(
      unitId: unitId ?? this.unitId,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name_en": nameEn,
      "name_ar": nameAr,
      "unit_id": unitId,
    };
  }

  @override
  List<Object?> get props => [
        nameAr,
        nameAr,
        unitId,
      ];

  static List<ProductUnit> list(List<Map<String, dynamic>> list) {
    return list.map((e) => ProductUnit.fromJson(e)).toList();
  }
}

class ProductImages extends Equatable {
  final String productId;
  final List<String> images;

  const ProductImages({
    required this.productId,
    required this.images,
  });

  factory ProductImages.fromJson(Map<String, dynamic> json) {
    return ProductImages(
      productId: json['product_id'],
      images: json['images'],
    );
  }

  factory ProductImages.initial() {
    return const ProductImages(productId: '', images: []);
  }

  ProductImages copyWith({String? productId, List<String>? images}) {
    return ProductImages(
      productId: productId ?? this.productId,
      images: images ?? this.images,
    );
  }

  ProductImages addImage(String img) {
    final List<String> imgs = images;
    if (!imgs.contains(img)) {
      imgs.add(img);
    }
    return ProductImages(
      productId: productId,
      images: imgs,
    );
  }

  ProductImages removeImage(String img) {
    final List<String> imgs = images;
    if (imgs.contains(img)) {
      imgs.remove(img);
    }
    return ProductImages(
      productId: productId,
      images: imgs,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'images': images,
    };
  }

  @override
  List<Object?> get props => [productId, images];

  @override
  String toString() => toJson().toString();
}
