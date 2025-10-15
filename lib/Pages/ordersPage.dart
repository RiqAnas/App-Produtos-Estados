import 'package:appprodutosestados/Components/appDrawer.dart';
import 'package:appprodutosestados/Components/orderListTile.dart';
import 'package:appprodutosestados/Models/orderList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orderspage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Orderlist orders = Provider.of<Orderlist>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedidos"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: Appdrawer(),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (context, index) =>
            Orderlisttile(order: orders.items[index]),
      ),
    );
  }
}
