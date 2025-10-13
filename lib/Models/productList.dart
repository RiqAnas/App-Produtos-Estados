import 'package:appprodutosestados/Data/dummyData.dart';
import 'package:appprodutosestados/Models/product.dart';
import 'package:flutter/material.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = DummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((item) => item.isFavorite!).toList();

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

  /*Forma Global

  bool _showFavoriteOnly = false;

  List<Product> get items {
    if (_showFavoriteOnly == true) {
      return _items.where((element) => element.isFavorite!).toList();
    } else
      return [..._items];
  }


  void showFavorite() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }
  */
}
