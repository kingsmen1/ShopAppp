import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({@required this.title,
    @required this.id,
    @required this.price,
    @required this.quantity});
}

class cart with ChangeNotifier {
  Map<String, CartItem> _itmes;

  Map<String, CartItem> get items {
    return {..._itmes};
  }

  void addItems(String productsId, double price, String title,) {
    if (_itmes.containsKey(productsId)) {
      _itmes.update(productsId, (existingCartItem) =>
          CartItem(id: existingCartItem.id,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1));
    } else {
      _itmes.putIfAbsent(productsId, () =>
          CartItem(title: title,
              id: DateTime.now().toString(),
              price: price,
              quantity: 1));
    }
  }
}


