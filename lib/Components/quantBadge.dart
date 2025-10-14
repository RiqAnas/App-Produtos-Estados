import 'package:flutter/material.dart';

class Quantbadge extends StatelessWidget {
  final Widget? child;
  final String? value;
  final Color? color;
  final bool? exists;

  Quantbadge({
    required this.child,
    required this.value,
    this.color = Colors.red,
    this.exists = true,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        child!,
        Positioned(
          right: 8,
          top: 8,
          child: exists!
              ? Container()
              : Container(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    value!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 6, color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: color,
                  ),
                  constraints: BoxConstraints(minHeight: 14, minWidth: 14),
                ),
        ),
      ],
    );
  }
}
