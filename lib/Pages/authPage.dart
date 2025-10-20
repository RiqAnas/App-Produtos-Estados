import 'package:appprodutosestados/Components/authForm.dart';
import 'package:flutter/material.dart';

class Authpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber, Colors.amberAccent, Colors.white],
                begin: AlignmentGeometry.topLeft,
                end: AlignmentGeometry.bottomRight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SingleChildScrollView(
                child: Card(elevation: 2, child: Authform()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


//o .. é um cascate operator,
//serve para realizar multíplas funções retornando o mesmo tipo da primeira
//(ex: num list..add(x)..add(y)..add(z) será retornado o tipo list), podendo ser realizados vários
//em cascata