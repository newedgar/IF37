import 'package:flutter/widgets.dart';
import 'package:toastification/toastification.dart';


class NotifManager {
  static final NotifManager _instance = NotifManager._internal();

  factory NotifManager() {
    return _instance;
  }

  NotifManager._internal();

  bool notifToastIsShowing = false;


  void showNotif({required ToastificationType type, required String title, String? description, int closeDuration = 3500}) async{
    if (notifToastIsShowing) {
      return;
    }

    notifToastIsShowing = true;

    toastification.show(
      title: Text(title),
      description: description != null ? Text(description) : null,
      type: type,
      //description: Text("description"),
      animationDuration: const Duration(milliseconds: 200),
      autoCloseDuration: Duration(milliseconds: closeDuration),
    );
    
    await Future.delayed(Duration(milliseconds: closeDuration+400))
        .then((_) {
          notifToastIsShowing = false;
        });
  }

}