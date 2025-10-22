import 'package:appprodutosestados/Models/product.dart';
import 'package:flutter/material.dart';

class Productdetailpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    final appBar = AppBar(
      title: Text(product.title.toString()),
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
    );

    final availableHeight =
        MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      //muito massa esse custom scrollView
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 50,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.title!),
              centerTitle: true,
              background: Container(color: Theme.of(context).primaryColor),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                spacing: 10,
                children: [
                  Container(
                    height: availableHeight * 0.45,
                    width: double.infinity,
                    child: SizedBox(
                      //Hero é pra a imagem dar uma seguida quando clicar para próxima página que
                      //tenha um hero com a mesma tag
                      child: Hero(
                        tag: product.id!,
                        child: Image.network(
                          product.imageUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "R\$ ${product.price!.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.description!,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
