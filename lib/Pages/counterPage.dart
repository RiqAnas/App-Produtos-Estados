import 'package:appprodutosestados/Providers/counter.dart';
import 'package:flutter/material.dart';

class Counterpage extends StatefulWidget {
  @override
  State<Counterpage> createState() => _CounterpageState();
}

class _CounterpageState extends State<Counterpage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Exemplo"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: <Widget>[
          Text(CounterProvider.of(context)!.state.value.toString()),
          IconButton(
            onPressed: () {
              setState(() {
                CounterProvider.of(context)!.state.inc();
              });

              print(CounterProvider.of(context)!.state.value.toString());
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                CounterProvider.of(context)!.state.dec();
              });
            },
            icon: Icon(Icons.reddit),
          ),
        ],
      ),
    );
  }
}
