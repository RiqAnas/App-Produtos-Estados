import 'package:appprodutosestados/Utils/appRoutes.dart';
import 'package:flutter/material.dart';

class Appdrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: Column(
        spacing: 15,
        children: [
          AppBar(
            title: Text("Bem vindo"),
            backgroundColor: Theme.of(context).primaryColor,
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag_rounded),
            title: Text("Shopping"),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(Approutes.HOME),
          ),
          ListTile(
            leading: Icon(Icons.view_list_rounded),
            title: Text("Pedidos"),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(Approutes.ORDERS),
          ),
        ],
      ),
    );
  }
}
