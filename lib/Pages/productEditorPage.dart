import 'package:appprodutosestados/Components/appDrawer.dart';
import 'package:appprodutosestados/Components/productEditorItem.dart';
import 'package:appprodutosestados/Models/productList.dart';
import 'package:appprodutosestados/Utils/appRoutes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Producteditorpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of<ProductList>(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Editor"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Approutes.PRODUCTFORM);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: Appdrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (context, index) =>
              Producteditoritem(product: products.items[index]),
        ),
      ),
    );
  }
}
