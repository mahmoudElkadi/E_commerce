import 'dart:convert';

import 'package:e_commerce_app/commponent/constants/errorHandling.dart';
import 'package:e_commerce_app/commponent/constants/globalVariables.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../commponent/constants/utiles.dart';
import '../../model/userModel.dart';
import '../../provider/userProvider.dart';


class UserServices{
  void addToCart({
    required BuildContext context,
    required String id,
  })async{
    final userProvider =Provider.of<UserProvider>(context,listen: false);

    try{
      http.Response res=await http.post(Uri.parse('$uri/product/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
        body:jsonEncode({
          'id':id,
        }),
      );

      httpErrorHandle(response: res,
          context: context,
          onSuccess:(){
            UserModel userModel=  userProvider.user.copyWith(
                cart: jsonDecode(res.body)['cart']);
            userProvider.setUserFromModel(userModel);

          });


    }
    catch(error){
      print(error.toString());
    }

  }


  void removeFromCart({
    required BuildContext context,
    required String id,
  })async{
    final userProvider =Provider.of<UserProvider>(context,listen: false);

    try{
      http.Response res=await http.delete(Uri.parse('$uri/product/remove-from-cart/${id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
      );

      httpErrorHandle(response: res,
          context: context,
          onSuccess:(){
            UserModel userModel=  userProvider.user.copyWith(
                cart: jsonDecode(res.body)['cart']);
            userProvider.setUserFromModel(userModel);

          });


    }
    catch(error){
      print(error.toString());
    }

  }

  void saveUserAddress({
    required context,
    required String address,
  }) async {
    try {
      final userProvider =Provider.of<UserProvider>(context,listen: false);

      http.Response res = await http.post(Uri.parse('$uri/product/save-user-address'),
          headers: <String, String>{
            'token': token,
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode({
            'address':address
          })

      );
      httpErrorHandle(response: res,
          context: context,
          onSuccess: () {
           UserModel userModel= userProvider.user.copyWith(
              address: jsonDecode(res.body)['address']
            );
           userProvider.setUserFromModel(userModel);
          }
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }


  void placeOrder({
    required context,
    required String address,
    required double totalSum
  }) async {
  //  try {
      final userProvider =Provider.of<UserProvider>(context,listen: false);
      print(userProvider.user.cart);
      http.Response res = await http.post(Uri.parse('$uri/product/save-user-order'),
          headers: <String, String>{
            'token': token,
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode({
            'cart':userProvider.user.cart,
            'address':address,
            'totalPrice':totalSum
          }),
      );

      UserModel userModel= userProvider.user.copyWith(
        cart: [],
      );
      userProvider.setUserFromModel(userModel);

      print(userProvider.user.cart);
      // httpErrorHandle(response: res,
      //     context: context,
      //     onSuccess: () {
      //   showSnackBar(context, 'Your Order has been placed!');
      //   //     UserModel userModel= userProvider.user.copyWith(
      //   //       cart: [],
      //   //         //address: jsonDecode(res.body)['address']
      //   //     );
      //   //     userProvider.setUserFromModel(userModel);
      //     }
      // );
    // } catch (error) {
    //   showSnackBar(context, error.toString());
    // }
  }


}