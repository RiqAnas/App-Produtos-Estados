import 'package:appprodutosestados/Models/product.dart';
import 'package:appprodutosestados/Models/productList.dart';
import 'package:appprodutosestados/Utils/appRoutes.dart';
import 'package:appprodutosestados/exceptions/httpException.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Producteditoritem extends StatelessWidget {
  final Product product;

  Producteditoritem({required this.product});

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    // TODO: implement build
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(product.imageUrl.toString()),
        ),
        title: Text(product.title!),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushNamed(Approutes.PRODUCTFORM, arguments: product);
                },
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Tem certeza?"),
                      content: Text(
                        "Tem certeza que quer apagar ${product.title} ?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text(
                            "Não",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Text(
                            "Sim",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ).then((value) async {
                    //se identificar que o valor selecionado não é falso (no caso ao clicar sim no
                    //alertDialog)
                    if (value ?? false) {
                      try {
                        await Provider.of<ProductList>(
                          context,
                          listen: false,
                        ).deleteProduct(product);
                      } on Httpexception catch (error) {
                        msg.showSnackBar(
                          SnackBar(content: Text(error.toString())),
                        );
                      }
                    }
                  });
                },
                icon: Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
