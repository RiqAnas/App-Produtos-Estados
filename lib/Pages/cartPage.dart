import 'package:appprodutosestados/Components/cartListItem.dart';
import 'package:appprodutosestados/Models/cart.dart';
import 'package:appprodutosestados/Models/orderList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cartpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                //pra deixar eles 1 no inicio, 1 no meio e 1 no final
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total", style: TextStyle(fontSize: 20)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: 100,
                      child: FittedBox(
                        child: Chip(
                          label: Text(
                            'R\$ ${cart.totalAmount.toStringAsFixed(2)}',
                          ),
                        ),
                      ),
                    ),
                  ),
                  //pra tirar o espaço entre o do meio e o do final
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      if (cart.items.values.isNotEmpty)
                        Provider.of<Orderlist>(
                          context,
                          listen: false,
                        ).addOrder(cart);
                      cart.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(15),
                      ),
                    ),
                    child: Text(
                      "Finalizar compra",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) =>
                  Cartlistitem(items: items[index]),
              itemCount: items.length,
            ),
          ),
        ],
      ),
    );
  }
}
