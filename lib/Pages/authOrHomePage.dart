import 'package:appprodutosestados/Models/auth.dart';
import 'package:appprodutosestados/Pages/authPage.dart';
import 'package:appprodutosestados/Pages/productsOverviewPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Authorhomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);
    // return auth.isAuth ? Productsoverviewpage() : Authpage();
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return Center(child: Text("Ocorreu  um erro"));
        } else {
          return auth.isAuth ? Productsoverviewpage() : Authpage();
        }
      },
    );
  }
}
