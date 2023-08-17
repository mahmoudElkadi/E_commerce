import 'dart:convert';
import 'dart:io';
import 'package:e_commerce_app/commponent/constants/errorHandling.dart';
import 'package:e_commerce_app/commponent/constants/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:e_commerce_app/commponent/constants/utiles.dart';
import 'package:e_commerce_app/model/product.dart';


class AdminServices {

  void sellProduct({
    required context,
    required String productName,
    required String description,
    required int price,
    required int quantity,
    required String catagory,
    required List<File> images,
  }) async {
    try {
      var cloudinary = CloudinaryPublic('dxsrhu3ku', 'eaqntkio');
      List<String>imagesUrl = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(images[i].path, folder: productName));
        imagesUrl.add(res.secureUrl);
      }

      ProductModel productModel = ProductModel(
        productName: productName,
        description: description,
        price: price,
        quantity: quantity,
        catagory: catagory,
        images: imagesUrl,
      );

      http.Response res = await http.post(Uri.parse('$uri/product'),
          headers: <String, String>{
            'token': token,
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: productModel.toJson()

      );
      httpErrorHandle(response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product Added Successfully');
            Navigator.pop(context);
          }
      );
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  List<ProductModel> productList = [];

  Future<List<ProductModel>> fetchAllProducts(BuildContext context) async {
    try {
      http.Response res =
      await http.get(Uri.parse('$uri/product'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      });



      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body)['products'].length; i++) {
            productList.add(
              ProductModel.fromJson(jsonDecode(res.body)['products'][i]),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return productList;
  }

   deleteProduct({
    required BuildContext context,
    ProductModel? productModel,
     String? id,
    required VoidCallback onSuccess
})async{

try{
  http.Response res=await http.delete(Uri.parse('$uri/product'),
    headers:{
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token,
    },
    body:jsonEncode({
      'id':id
    }),
  );

  httpErrorHandle(
      response: res,
      context: context,
      onSuccess: (){onSuccess();}
  );
}catch(error){
  showSnackBar(context, error.toString());
}
  }


}
