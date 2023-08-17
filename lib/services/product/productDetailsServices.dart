import 'dart:convert';

import 'package:e_commerce_app/commponent/constants/errorHandling.dart';
import 'package:e_commerce_app/commponent/constants/globalVariables.dart';
import 'package:e_commerce_app/model/userModel.dart';

import 'package:e_commerce_app/provider/userProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices{
  void rateProduct({
    required BuildContext context,
    required String id,
    required double rating
})async{
    final userProvider =Provider.of<UserProvider>(context,listen: false);

    try{
      http.Response res=await http.post(Uri.parse('$uri/product/rating'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
        body:jsonEncode({
          'id':id,
          'rating': rating
        }),
      );

      httpErrorHandle(response: res,
          context: context,
          onSuccess:(){});


   }
    catch(error){
      print(error.toString());
    }

  }



}