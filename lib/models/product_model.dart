import 'package:equatable/equatable.dart';

class Product {
  final String id;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final String productKey;
  final List<String> categories;
  final List<ProductFeature> features;
  final ProductPrice price;
  final ProductInventory inventory;

  Product({
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.productKey,
    required this.id,
    required this.categories,
    required this.features,
    required this.price,
    required this.inventory,
  });
}

class ProductCategory {
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final String categoryId;

  ProductCategory({
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.categoryId,
  });
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

class ProductPrice {
  final String productId;
  final double price;
  final double discount;

  ProductPrice({
    required this.productId,
    required this.price,
    required this.discount,
  });
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
