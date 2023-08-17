import 'package:e_commerce_app/model/userModel.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  UserModel userModel=UserModel(
    id: '',
    userName: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
    cart: []
  );
  UserModel get user => userModel;
void setUser(String user){
  userModel=UserModel.fromJson(user);
  notifyListeners();
}

void setUserFromModel(UserModel user){
  userModel = user;
  notifyListeners();
}


}