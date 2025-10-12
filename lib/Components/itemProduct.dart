import 'package:appprodutosestados/Models/product.dart';
import 'package:appprodutosestados/Utils/appRoutes.dart';
import 'package:flutter/material.dart';

class Itemproduct extends StatelessWidget {
  final Product? product;

  const Itemproduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: Text(product!.title.toString(), textAlign: TextAlign.center),
          backgroundColor: Colors.black54,
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
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
          child: Image.network(product!.imageUrl.toString(), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
