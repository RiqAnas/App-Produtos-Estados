import 'package:appprodutosestados/Components/itemProduct.dart';
import 'package:appprodutosestados/Models/product.dart';
import 'package:appprodutosestados/Models/productList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class productsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> products = provider.items;

    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      //CNP.value indica que será passada uma Notifier e o value indica o que será passado
      //nesse caso, um produto da lista de produto no index referido no grid, a diferença do
      //.value é por ser um objeto já criado, sendo apenas passado para outra classe
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: Itemproduct(),
      ),
    );
  }
}
