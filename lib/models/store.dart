import 'package:desafio_gas/models/brand.dart';
import 'package:flutter/foundation.dart';

class Store {
  final String name;
  final Brand brand;
  final double rating;
  final DeliveryTime averageDeliveryTime;
  final double price;
  final bool isBestPrice;

  Store({
    @required this.name,
    @required this.brand,
    @required this.rating,
    @required this.averageDeliveryTime,
    @required this.price,
    @required this.isBestPrice,
  });
}

class DeliveryTime {
  final int min;
  final int max;

  DeliveryTime({@required this.min, @required this.max});
}
