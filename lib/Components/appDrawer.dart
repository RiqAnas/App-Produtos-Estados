import 'package:appprodutosestados/Models/auth.dart';
import 'package:appprodutosestados/Utils/appRoutes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            onTap: () => Navigator.of(
              context,
            ).pushReplacementNamed(Approutes.AUTHORHOMEPAGE),
          ),
          ListTile(
            leading: Icon(Icons.view_list_rounded),
            title: Text("Pedidos"),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(Approutes.ORDERS),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Editar Produtos"),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(Approutes.EDITOR),
          ),
          SizedBox(height: 400),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Sair"),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(
                context,
              ).pushReplacementNamed(Approutes.AUTHORHOMEPAGE);
            },
          ),
        ],
      ),
    );
  }
}
