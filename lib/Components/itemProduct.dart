import 'package:appprodutosestados/Models/product.dart';
import 'package:appprodutosestados/Utils/appRoutes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Itemproduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //"pega" um product passado para ele
    final product = Provider.of<Product>(context);
    // TODO: implement build
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: Text(product.title.toString(), textAlign: TextAlign.center),
          backgroundColor: Colors.black54,
          leading: IconButton(
            onPressed: () {
              product.toggleFavorite();
            },
            icon: Icon(
              Icons.favorite,
              color: product.isFavorite! ? Colors.red : Colors.white,
            ),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(
              context,
            ).pushNamed(Approutes.ITEMPRODUCT, arguments: product);
          },
          child: Image.network(product.imageUrl.toString(), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
