import 'package:appprodutosestados/Components/appDrawer.dart';
import 'package:appprodutosestados/Components/orderListTile.dart';
import 'package:appprodutosestados/Models/orderList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orderspage extends StatelessWidget {
  Future<void> _refreshOrders(BuildContext context) {
    return Provider.of<Orderlist>(context, listen: false).loadOrder();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedidos"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: Appdrawer(),
      //futureBuilder faz a questão do initState e loading (presentes no OverviewPage) não serem necessários,
      //podendo fazer com que a classe possa permanecer no statelesswidget (é possível colocar um else if
      //ali dentro do builder tb para em casos de erro)
      body: FutureBuilder(
        future: Provider.of<Orderlist>(context, listen: false).loadOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          } else {
            return Consumer<Orderlist>(
              builder: (context, orders, child) => RefreshIndicator(
                onRefresh: () => _refreshOrders(context),
                color: Theme.of(context).primaryColor,
                child: ListView.builder(
                  itemCount: orders.itemsCount,
                  itemBuilder: (context, index) =>
                      Orderlisttile(order: orders.items[index]),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
