import 'package:appprodutosestados/Components/appDrawer.dart';
import 'package:appprodutosestados/Components/productsGrid.dart';
import 'package:appprodutosestados/Components/quantBadge.dart';
import 'package:appprodutosestados/Models/cart.dart';
import 'package:appprodutosestados/Models/productList.dart';
import 'package:appprodutosestados/Utils/appRoutes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Filtereds { Favorites, All }

class Productsoverviewpage extends StatefulWidget {
  @override
  State<Productsoverviewpage> createState() => _ProductsoverviewpageState();
}

class _ProductsoverviewpageState extends State<Productsoverviewpage> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductList>(context, listen: false).loadProducts().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.star),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Favoritos'),
                value: Filtereds.Favorites,
              ),
              PopupMenuItem(child: Text('Todos'), value: Filtereds.All),
            ],
            onSelected: (Filtereds selectedValue) {
              setState(() {
                if (selectedValue == Filtereds.Favorites) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Approutes.CART);
              },
              icon: Icon(Icons.shopping_cart),
            ),
            builder: (ctx, cart, child) => Quantbadge(
              value: cart.itemsCount.toString(),
              child: child!,
              exists: cart.items.isEmpty,
            ),
          ),
        ],
        title: Text("Lojinha"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : productsGrid(favoriteOnly: _showFavoriteOnly),
      drawer: Appdrawer(),
    );
  }
}
