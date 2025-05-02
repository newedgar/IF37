import 'package:flutter/material.dart';

import 'main_container.dart';

Container listViewContainer({Widget? child,EdgeInsetsGeometry? padding}) {
  
  return mainContainer(
    margin: EdgeInsets.all(10),
    padding: padding ?? EdgeInsets.symmetric(horizontal: 5),
    child: child,
  );
}
