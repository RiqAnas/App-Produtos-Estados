import 'package:appprodutosestados/Models/product.dart';
import 'package:flutter/material.dart';

class Productdetailpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    final appBar = AppBar(
      title: Text(product.title.toString()),
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
    );

    final availableHeight =
        MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          spacing: 10,
          children: [
            Container(
              height: availableHeight * 0.45,
              width: double.infinity,
              child: SizedBox(
                child: Image.network(product.imageUrl!, fit: BoxFit.cover),
              ),
            ),
            Center(
              child: Text(
                "R\$ ${product.price!.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.description!,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
