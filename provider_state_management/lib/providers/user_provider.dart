import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String userName;
  int num = 0;

  UserProvider({
    this.userName = "Home",
  });

  void changeUserName({required String newUserName}) async {
    userName = newUserName;
    notifyListeners();
  }

  void increment(){
    num++;
    notifyListeners();
  }
  void decrement(){
    if(num == 0) return;
    num--;
    notifyListeners();
  }

}
