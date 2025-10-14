import 'dart:math';

import 'package:appprodutosestados/Models/cartItem.dart';
import 'package:appprodutosestados/Models/product.dart';
import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, CartItem) {
      total += CartItem.price * CartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id!,
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: existingItem.productId,
          productName: existingItem.productName,
          price: existingItem.price,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id!,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id!,
          productName: product.title!,
          price: product.price!,
          quantity: 1,
        ),
      );
      notifyListeners();
    }
  }

  void diminuteItem(CartItem cartI) {
    if (cartI.quantity > 1) {
      final cartItem = _items.values.firstWhere((value) => value == cartI);
      _items.update(
        cartItem.productId,
        (item) => CartItem(
          id: item.id,
          productId: item.productId,
          productName: item.productName,
          price: item.price,
          quantity: item.quantity - 1,
        ),
      );
    } else {
      _items.remove(cartI.productId);
      notifyListeners();
    }

    notifyListeners();
  }

  //só colocar NL nas que alteram o estado interno da classe

  void clear() {
    _items = {};
    notifyListeners();
  }
}
