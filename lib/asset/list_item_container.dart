import 'package:flutter/material.dart';



Container listItemContainer({Widget? child  }) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 202, 210, 227),

      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(60),
          spreadRadius: 2,
          blurRadius: 4,
          offset: Offset(0.5, 1.5), // changes position of shadow
        ),
      ],
    ),
    child: child,
  );
}