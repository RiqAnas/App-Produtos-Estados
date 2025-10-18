import 'dart:convert';

import 'package:appprodutosestados/Models/cart.dart';
import 'package:appprodutosestados/Models/cartItem.dart';
import 'package:appprodutosestados/Models/order.dart';
import 'package:appprodutosestados/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Orderlist extends ChangeNotifier {
  final _baseUrl = Constants.BASEURLORDER;
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrder() async {
    _items.clear();
    final response = await http.get(Uri.parse("$_baseUrl.json"));
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((orderId, orderValue) {
      _items.add(
        //quando foi muitos pra 1 e ser necessário ter lista(como é NoSql n sei como se classificaria isso)
        Order(
          id: orderId,
          date: DateTime.parse(orderValue['date']),
          total: orderValue['total'],
          products: (orderValue['products'] as List<dynamic>).map((item) {
            return CartItem(
              id: item['id'],
              productId: item['productId'],
              productName: item['productName'],
              quantity: item['quantity'],
              price: item['price'],
            );
          }).toList(),
        ),
      );
    });
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse("$_baseUrl.json"),
      body: jsonEncode(<String, Object>{
        'total': cart.totalAmount,
        'date': date.toIso8601String(),
        'products': cart.items.values
            .map(
              (cartItem) => {
                'id': cartItem.id,
                'productId': cartItem.productId,
                'productName': cartItem.productName,
                'price': cartItem.price,
                'quantity': cartItem.quantity,
              },
            )
            .toList(),
      }),
    );

    final id = jsonDecode(response.body)['name'];

    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: date,
      ),
    );
    notifyListeners();
  }
}
