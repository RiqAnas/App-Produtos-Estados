import 'package:appprodutosestados/Models/product.dart';
import 'package:flutter/material.dart';

class Productdetailpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title.toString()),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(child: Text(product.title.toString())),
    );
  }
}
