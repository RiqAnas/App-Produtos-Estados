import 'package:appprodutosestados/Models/cart.dart';
import 'package:appprodutosestados/Models/cartItem.dart';
import 'package:appprodutosestados/Models/productList.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cartlistitem extends StatelessWidget {
  final CartItem? items;

  Cartlistitem({required this.items});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    Provider.of<ProductList>(
                      context,
                      listen: false,
                    ).productUrlById(items!.productId),
                  ),
                ),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                child: SizedBox(
                  child: Text(items!.productName, overflow: TextOverflow.fade),
                ),
              ),
              Text(
                "R\$${items!.price}",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Chip(
              label: Text(
                "R\$ ${(items!.price * items!.quantity).toStringAsFixed(2)}",
              ),
            ),
          ),
          Spacer(),
          Text("${items!.quantity}x"),
          IconButton(
            onPressed: () {
              if (items!.quantity == 1) {
                //mostrar um popUp de decisão
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Tem certeza?"),
                    content: Text(
                      "Quer remover ${items!.productName} do carrinho?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(
                          "Não",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                          Provider.of<Cart>(
                            context,
                            listen: false,
                          ).diminuteItem(items!.productId);
                        },
                        child: Text(
                          "Sim",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                Provider.of<Cart>(
                  context,
                  listen: false,
                ).diminuteItem(items!.productId);
              }
            },
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
