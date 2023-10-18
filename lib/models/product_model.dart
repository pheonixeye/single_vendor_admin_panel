import 'package:equatable/equatable.dart';

class Product extends Equatable {
  //FIXME: ADD CATEGORY ID
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

  factory Product.initial() {
    return const Product(
      productId: '',
      nameEn: '',
      nameAr: '',
      descriptionEn: '',
      descriptionAr: '',
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

  static List<Product> productListFromJson(List<Map<String, dynamic>> list) {
    return list.map((e) => Product.fromJson(e)).toList();
  }
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

enum SpecialValueType {
  int,
  bool,
  double,
  none;

  static SpecialValueType fromString(String value) {
    switch (value) {
      case 'int':
        return SpecialValueType.int;
      case 'double':
        return SpecialValueType.double;
      case 'bool':
        return SpecialValueType.bool;
      default:
        return SpecialValueType.none;
    }
  }
}

class ProductFeature extends Equatable {
  final String? id;
  final int sort;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final String productId;
  final bool hasSpecialValue;
  final SpecialValueType specialValueType;
  final int? specialValueInt;
  final double? specialValueDouble;
  final bool? specialValueBool;

  String get svt => specialValueType.name;

  const ProductFeature({
    required this.id,
    required this.sort,
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

  factory ProductFeature.fromJson(Map<String, dynamic> json) {
    return ProductFeature(
      id: json[r'$id'],
      sort: json['sort'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      descriptionEn: json['description_en'],
      descriptionAr: json['description_ar'],
      productId: json['product_id'],
      hasSpecialValue: json['has_special_value'],
      specialValueType: SpecialValueType.fromString(json['special_value_type']),
      specialValueInt: json['special_value_int'],
      specialValueDouble: json['special_value_double'],
      specialValueBool: json['special_value_bool'],
    );
  }

  factory ProductFeature.initial() {
    return const ProductFeature(
      id: null,
      sort: 0,
      nameEn: '',
      nameAr: '',
      descriptionEn: '',
      descriptionAr: '',
      productId: '',
      hasSpecialValue: false,
      specialValueType: SpecialValueType.none,
      specialValueInt: null,
      specialValueDouble: null,
      specialValueBool: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sort': sort,
      'name_en': nameEn,
      'name_ar': nameAr,
      'description_en': descriptionEn,
      'description_ar': descriptionAr,
      'product_id': productId,
      'has_special_value': hasSpecialValue,
      'special_value_type': specialValueType.name,
      'special_value_int': specialValueInt,
      'special_value_double': specialValueDouble,
      'special_value_bool': specialValueBool,
    };
  }

  ProductFeature copyWith({
    String? id,
    int? sort,
    String? nameEn,
    String? nameAr,
    String? descriptionEn,
    String? descriptionAr,
    String? productId,
    bool? hasSpecialValue,
    SpecialValueType? specialValueType,
    int? specialValueInt,
    double? specialValueDouble,
    bool? specialValueBool,
  }) {
    return ProductFeature(
      id: id ?? this.id,
      sort: sort ?? this.sort,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      productId: productId ?? this.productId,
      hasSpecialValue: hasSpecialValue ?? this.hasSpecialValue,
      specialValueType: specialValueType ?? this.specialValueType,
      specialValueInt: specialValueInt ?? this.specialValueInt,
      specialValueDouble: specialValueDouble ?? this.specialValueDouble,
      specialValueBool: specialValueBool ?? this.specialValueBool,
    );
  }

  Map<String, dynamic> forPrint() {
    return {
      'id': id,
      'sort': sort,
      'name_en': nameEn,
      'name_ar': nameAr,
      'description_en': descriptionEn,
      'description_ar': descriptionAr,
      'product_id': productId,
      'has_special_value': hasSpecialValue,
      'special_value_type': specialValueType.name,
      'special_value_int': specialValueInt,
      'special_value_double': specialValueDouble,
      'special_value_bool': specialValueBool,
    };
  }

  @override
  String toString() {
    return forPrint().toString();
  }

  @override
  List<Object?> get props => [
        id,
        sort,
        nameEn,
        nameAr,
        descriptionEn,
        descriptionAr,
        productId,
        hasSpecialValue,
        specialValueType,
        specialValueDouble,
        specialValueBool,
        specialValueInt
      ];
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
      price: json['price'].toDouble(),
      discount: json['discount'].toDouble(),
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
      images: _ListDynamicToListString(json['images']),
    );
  }

  factory ProductImages.initial() {
    return const ProductImages(
      productId: '',
      images: [],
    );
  }

  ProductImages copyWith({String? productId, List<String>? images}) {
    return ProductImages(
      productId: productId ?? this.productId,
      images: images ?? this.images,
    );
  }

  ProductImages addImage(String img) {
    if (!images.contains(img)) {
      images.add(img);
    }
    return ProductImages(
      productId: productId,
      images: images,
    );
  }

  ProductImages removeImage(String img) {
    if (images.contains(img)) {
      images.remove(img);
    }
    return ProductImages(
      productId: productId,
      images: images,
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

// ignore: non_constant_identifier_names
List<String> _ListDynamicToListString(List<dynamic> list) {
  return list.map((e) => e.toString()).toList();
}
