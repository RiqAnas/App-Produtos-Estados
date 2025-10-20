import 'package:flutter/material.dart';

class Formfielddecoration extends StatelessWidget {
  final Widget child;
  final bool? error;

  Formfielddecoration({required this.child, this.error});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: BoxBorder.all(
            color: !error! ? Colors.grey : Colors.red,
            width: 2,
          ),
        ),
        child: child,
        padding: EdgeInsets.symmetric(horizontal: 5),
      ),
    );
  }
}
