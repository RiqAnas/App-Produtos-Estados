import 'dart:convert';
import 'dart:math';

import 'package:appprodutosestados/Models/product.dart';
import 'package:appprodutosestados/Utils/constants.dart';
import 'package:appprodutosestados/exceptions/httpException.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductList with ChangeNotifier {
  final _baseUrl = Constants.BASEURL;
  List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((item) => item.isFavorite!).toList();

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(Uri.parse("$_baseUrl.json"));
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      _items.add(
        Product(
          id: productId,
          title: productData["name"],
          description: productData["description"],
          price: productData["price"],
          imageUrl: productData["imageUrl"],
          isFavorite: productData["isFavorite"],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
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
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> updateProduct(Product product) async {
    //sempre volta um valor de indíce e por padrão se for -1 é inválido
    int index = _items.indexWhere((pr) => pr.id == product.id);
    //substitui o produto do deteminado index pelo produto atualizado
    if (index >= 0) {
      await http.patch(
        Uri.parse("$_baseUrl/${product.id}.json"),
        body: jsonEncode({
          "name": product.title,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
        }),
      );
      _items[index] = product;
      notifyListeners();
    }

    return Future.value();
  }

  //métodos async obrigatoriamente retornam Future
  Future<void> addProduct(Product product) async {
    //await faz com que vira uma response(o retorno de future) pois o future vira a expressão em si,
    //faz com que se espere pelo valor do future e passe ele pra a resposta
    final response = await http.post(
      //convenção do fireBase colocar .json no final da Url
      Uri.parse("$_baseUrl.json"),
      body: jsonEncode(<String, Object>{
        "name": product.title as String,
        "description": product.description as String,
        "price": product.price as double,
        "imageUrl": product.imageUrl as String,
        "isFavorite": product.isFavorite as bool,
      }),
    );
    //retorna o .then da operação de adicionar ao banco, que é a que adiciona o produto localmente
    //pode colocar para executar um código apenas quando a resposta for processada
    final id = jsonDecode(response.body)['name'];
    _items.add(
      Product(
        id: id,
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      ),
    );
    //atualiza os interessados que utilizarão a lista, gerando a atualização da classe
    notifyListeners();
  }

  Future<void> deleteProduct(Product product) async {
    int nIndex = _items.indexWhere((pr) => pr.id == product.id);
    if (nIndex >= 0) {
      _items.remove(_items[nIndex]);
      notifyListeners();
      //nesse caso se exclui pro usuário enquanto nos bastidores se exclui no banco
      final response = await http.delete(
        Uri.parse("$_baseUrl/${product.id}.json"),
      );

      //400 = lado do cliente, 500 = lado do servidor
      if (response.statusCode >= 400) {
        _items.insert(nIndex, product);
        notifyListeners();
        throw Httpexception(
          statusCode: response.statusCode,
          msg: "Não foi possível excluir o produto",
        );
      }
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
