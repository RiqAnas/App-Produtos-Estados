import 'package:appprodutosestados/Components/productsGrid.dart';
import 'package:flutter/material.dart';

class Productsoverviewpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lojinha"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: productsGrid(),
    );
  }
}
