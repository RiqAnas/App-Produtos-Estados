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
                  cartButton(cart: cart),
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

class cartButton extends StatefulWidget {
  const cartButton({super.key, required this.cart});

  final Cart cart;

  @override
  State<cartButton> createState() => _cartButtonState();
}

class _cartButtonState extends State<cartButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          )
        : ElevatedButton(
            onPressed: widget.cart.itemsCount == 0
                ? null
                : () async {
                    setState(() => _isLoading = true);
                    await Provider.of<Orderlist>(
                      context,
                      listen: false,
                    ).addOrder(widget.cart).then((_) {});

                    widget.cart.clear();
                    setState(() {
                      _isLoading = false;
                    });
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
          );
  }
}
