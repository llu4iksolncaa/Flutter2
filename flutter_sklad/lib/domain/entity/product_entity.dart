import 'dart:ffi';

class ProductEntity {
  int? id;
  late String description;
  late double price;
  late String name;
  late int exists;
  late int productCategoryId;
  late int stockId;
  late int count;
  late String vendor;

  ProductEntity({required this.description, required this.price, required this.name, required this.exists, required this.productCategoryId, required this.stockId, required this.count, required this.vendor}); 
}