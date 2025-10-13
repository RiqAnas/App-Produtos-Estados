import 'package:appprodutosestados/Components/productsGrid.dart';
import 'package:flutter/material.dart';

enum Filtereds { Favorites, All }

class Productsoverviewpage extends StatefulWidget {
  @override
  State<Productsoverviewpage> createState() => _ProductsoverviewpageState();
}

class _ProductsoverviewpageState extends State<Productsoverviewpage> {
  bool _showFavoriteOnly = false;
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
        ],
        title: Text("Lojinha"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: productsGrid(favoriteOnly: _showFavoriteOnly),
    );
  }
}
