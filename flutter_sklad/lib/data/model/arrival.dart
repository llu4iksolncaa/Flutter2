import 'package:flutter_sklad/domain/entity/arrival_entity.dart';

class Arrival extends ArrivalEntity {
  int? id;
  late String date;
  late int count;
  late int providerId;
  late int productId;

  Arrival({required this.date, required this.count, required this.providerId, required this.productId}) : super(date: date, count: count, providerId: providerId, productId: productId);

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'count': count,
      'providerId': providerId,
      'productId': productId
    };
  }

  factory Arrival.toFromMap(Map<String, dynamic> json) {
    return Arrival(date: json['date'], count: json['count'], providerId: json['providerId'], productId: json['productId']);
  }
}
