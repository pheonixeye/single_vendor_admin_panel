import 'package:equatable/equatable.dart';

class CatToProd extends Equatable {
  final String nameEn;
  final String nameAr;
  final String categoryId;
  final List<String> products;

  const CatToProd({
    required this.nameEn,
    required this.nameAr,
    required this.categoryId,
    required this.products,
  });

  factory CatToProd.initial() {
    return const CatToProd(
      nameEn: '',
      nameAr: '',
      categoryId: '',
      products: [],
    );
  }

  CatToProd addProduct({required String newProduct}) {
    return CatToProd(
      nameEn: nameEn,
      nameAr: nameAr,
      categoryId: categoryId,
      products: products..add(newProduct),
    );
  }

  CatToProd removeProduct({required String product}) {
    return CatToProd(
      nameEn: nameEn,
      nameAr: nameAr,
      categoryId: categoryId,
      products: products..removeWhere((element) => element == product),
    );
  }

  factory CatToProd.fromJson(Map<String, dynamic> json) {
    return CatToProd(
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      categoryId: json['category_id'],
      products: _helper(json['products']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name_en': nameEn,
      'name_ar': nameAr,
      'category_id': categoryId,
      'products': products,
    };
  }

  static List<String> _helper(List<dynamic> list) {
    return list.map((e) => e.toString()).toList();
  }

  static List<CatToProd> ctpList(List<Map<String, dynamic>> list) {
    return list.map((e) => CatToProd.fromJson(e)).toList();
  }

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  List<Object?> get props => [nameEn, nameAr, categoryId, products];
}
