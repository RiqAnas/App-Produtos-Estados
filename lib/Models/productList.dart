import 'package:appprodutosestados/Data/dummyData.dart';
import 'package:appprodutosestados/Models/product.dart';
import 'package:flutter/material.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = DummyProducts;

  List<Product> get items => [..._items];

  void addProduct(Product product) {
    _items.add(product);
    //atualiza os interessados que utilizarão a lista, gerando a atualização da calsse
    notifyListeners();
  }

  void removeProduct(Product product) {
    _items.remove(product);
    //atualiza os interessados que utilizarão a lista, gerando a atualização da calsse
    notifyListeners();
  }
}
