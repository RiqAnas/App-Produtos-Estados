import 'package:appprodutosestados/Models/cart.dart';
import 'package:appprodutosestados/Models/product.dart';
import 'package:appprodutosestados/Utils/appRoutes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Itemproduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //"pega" um product passado para ele
    //o listen define se essa classe irá "escutar" os efeitos do provider
    //(ou seja não irá mudar o ícone), o false é bom para dados imutáveis

    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: Text(product.title.toString(), textAlign: TextAlign.center),
          backgroundColor: Colors.black54,
          //há essa opção ao invés do provider, é útil para aplica-lo únicamente no lugar da mudança
          leading: Consumer<Product>(
            builder: (context, product, child) => IconButton(
              onPressed: () {
                product.toggleFavorite();
              },
              icon: Icon(
                Icons.favorite,
                color: product.isFavorite! ? Colors.red : Colors.white,
              ),
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product);
            },
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
