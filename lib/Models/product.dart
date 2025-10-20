import 'dart:convert';

import 'package:appprodutosestados/Utils/constants.dart';
import 'package:appprodutosestados/exceptions/httpException.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final _baseUrl = Constants.USERFAVORITEURL;
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final String? imageUrl;
  bool? isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _changeFavorite() {
    isFavorite = !isFavorite!;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, String userId) async {
    _changeFavorite();

    final response = await http.put(
      Uri.parse("$_baseUrl/$userId/$id.json?auth=$token"),
      body: jsonEncode(isFavorite),
    );

    if (response.statusCode >= 400) {
      _changeFavorite();
      throw Httpexception(
        statusCode: response.statusCode,
        msg: "Houve um erro ao tentar alterar status de favorito.",
      );
    }
  }
}
