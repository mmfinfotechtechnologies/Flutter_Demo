import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_shopping_cart/src/catalog.dart';

@immutable
class Cart extends Equatable {
  final Product _product;
  final List<int> _itemIds;

  Cart(this._product, Cart previous)
      : assert(_product != null),
        _itemIds = previous?._itemIds ?? [];

  @override
  List<Object> get props => [_product, _itemIds];
}
