import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_shopping_cart/src/catalog.dart';

@immutable
class Product extends Equatable {
  static const _itemNames = [
    'Reebok',
    'adidas',
    'Nike',
    'Puma'
  ];

  Item getById(int id) => Item(id, _itemNames[id % _itemNames.length]);

  Item getByPosition(int position) => getById(position);

  @override
  List<Object> get props => [_itemNames];
}
