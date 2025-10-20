import 'package:appprodutosestados/Models/auth.dart';
import 'package:appprodutosestados/Pages/authPage.dart';
import 'package:appprodutosestados/Pages/productsOverviewPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Authorhomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);
    return auth.isAuth ? Productsoverviewpage() : Authpage();
  }
}
