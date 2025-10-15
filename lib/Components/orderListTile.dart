import 'package:appprodutosestados/Models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Orderlisttile extends StatefulWidget {
  final Order order;

  Orderlisttile({required this.order});

  @override
  State<Orderlisttile> createState() => _OrderlisttileState();
}

class _OrderlisttileState extends State<Orderlisttile> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Column(
        children: [
          ListTile(
            isThreeLine: true,
            title: Text(
              "Pedido #${widget.order.id.toString().substring(3, 8)}",
            ),
            subtitle: Text(
              "${DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date!)}\nR\$ ${widget.order.total!.toStringAsFixed(2)}",
            ),
            trailing: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(Icons.expand_more, color: Colors.black),
              ),
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              height: 200,
              child: ListView(
                children: widget.order.products!.map((product) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      spacing: 10,
                      children: [
                        Container(
                          width: 100,
                          child: SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.productName),
                                Text(
                                  "R\$ ${product.price.toStringAsFixed(2)}",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text("${product.quantity}x"),
                        Spacer(),
                        Text(
                          "R\$ ${(product.price * product.quantity).toStringAsFixed(2)}",
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
