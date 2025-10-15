import 'dart:math';

import 'package:appprodutosestados/Data/dummyData.dart';
import 'package:appprodutosestados/Models/product.dart';
import 'package:flutter/material.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = DummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((item) => item.isFavorite!).toList();

  int get itemsCount {
    return _items.length;
  }

  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      //caso seja um produto já existente(com id) mantém o mesmo id, para realizar a busca
      //depois
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      title: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['url'] as String,
    );
    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }

    notifyListeners();
  }

  void updateProduct(Product product) {
    //sempre volta um valor de indíce e por padrão se for -1 é inválido
    int index = _items.indexWhere((pr) => pr.id == product.id);
    //substitui o produto do deteminado index pelo produto atualizado
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void addProduct(Product product) {
    _items.add(product);
    //atualiza os interessados que utilizarão a lista, gerando a atualização da calsse
    notifyListeners();
  }

  void deleteProduct(Product product) {
    int nIndex = _items.indexWhere((pr) => pr.id == product.id);
    if (nIndex >= 0) {
      _items.remove(_items[nIndex]);
      notifyListeners();
    }
  }

  String productUrlById(String id) {
    final filteredProduct = _items.firstWhere((product) => product.id == id);
    return filteredProduct.imageUrl!;
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
