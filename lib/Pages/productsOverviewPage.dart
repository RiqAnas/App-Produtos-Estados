import 'package:appprodutosestados/Components/itemProduct.dart';
import 'package:appprodutosestados/Data/dummyData.dart';
import 'package:appprodutosestados/Models/product.dart';
import 'package:flutter/material.dart';

class Productsoverviewpage extends StatelessWidget {
  final List<Product> products = DummyProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lojinha"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) => Itemproduct(product: products[index]),
      ),
    );
  }
}
