import 'dart:math';

import 'package:appprodutosestados/Models/cart.dart';
import 'package:appprodutosestados/Models/order.dart';
import 'package:flutter/material.dart';

class Orderlist extends ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  void addOrder(Cart cart) {
    _items.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
