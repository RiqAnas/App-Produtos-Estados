import 'package:appprodutosestados/Models/auth.dart';
import 'package:appprodutosestados/Models/cart.dart';
import 'package:appprodutosestados/Models/orderList.dart';
import 'package:appprodutosestados/Models/productList.dart';
import 'package:appprodutosestados/Pages/authOrHomePage.dart';
import 'package:appprodutosestados/Pages/authPage.dart';
import 'package:appprodutosestados/Pages/cartPage.dart';
import 'package:appprodutosestados/Pages/ordersPage.dart';
import 'package:appprodutosestados/Pages/productDetailPage.dart';
import 'package:appprodutosestados/Pages/productEditorPage.dart';
import 'package:appprodutosestados/Pages/productFormPage.dart';
import 'package:appprodutosestados/Pages/productsOverviewPage.dart';

import 'package:appprodutosestados/Utils/appRoutes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Envolver o materialApp com o CNP para conseguir pegar os dados em qualquer local
    //criando e passando uma nova classe
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orderlist()),
        ChangeNotifierProvider(create: (_) => Auth()),
      ],
      child: MaterialApp(
        title: "app Loja",
        theme: ThemeData(
          textTheme: GoogleFonts.alexandriaTextTheme(),
          primaryColor: Colors.amber,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          Approutes.AUTHORHOMEPAGE: (ctx) => Authorhomepage(),
          Approutes.ITEMPRODUCT: (ctx) => Productdetailpage(),
          Approutes.CART: (ctx) => Cartpage(),
          Approutes.ORDERS: (ctx) => Orderspage(),
          Approutes.EDITOR: (ctx) => Producteditorpage(),
          Approutes.PRODUCTFORM: (ctx) => Productformpage(),
        },
      ),
    );
  }
}
