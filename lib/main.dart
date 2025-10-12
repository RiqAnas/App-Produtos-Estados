import 'package:appprodutosestados/Pages/productDetailPage.dart';
import 'package:appprodutosestados/Pages/productsOverviewPage.dart';

import 'package:appprodutosestados/Utils/appRoutes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "app Loja",
      theme: ThemeData(
        textTheme: GoogleFonts.alexandriaTextTheme(),
        primaryColor: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        Approutes.HOME: (ctx) => Productsoverviewpage(),
        Approutes.ITEMPRODUCT: (ctx) => Productdetailpage(),
      },
    );
  }
}
