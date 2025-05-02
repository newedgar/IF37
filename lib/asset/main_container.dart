import 'package:flutter/material.dart';



Container mainContainer({Widget? child, EdgeInsetsGeometry margin = const EdgeInsets.all(0), 
  EdgeInsetsGeometry padding = const EdgeInsets.all(10)}) {

  return Container(
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 184, 194, 227),
      borderRadius: BorderRadius.circular(17),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(60),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(1, 3), // changes position of shadow
        ),
      ],
    ),
    child: child,
  );
}