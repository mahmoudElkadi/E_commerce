import 'dart:convert';

import 'package:e_commerce_app/commponent/constants/errorHandling.dart';
import 'package:e_commerce_app/commponent/constants/globalVariables.dart';
import 'package:e_commerce_app/commponent/constants/utiles.dart';
import 'package:e_commerce_app/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductServies{
  Future<List<ProductModel>?> fetshCategoryProduct(
      { required BuildContext context,required String category})async{
    List <ProductModel> products=[];
   http.Response res= await http.get(Uri.parse('$uri/product/category?catagory=$category'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token,
    },
    );
   print(jsonDecode(res.body));
   httpErrorHandle(response: res, context: context, onSuccess: (){
     for(int i=0;i<jsonDecode(res.body)['products'].length;i++)
     products.add(
         ProductModel.fromJson(jsonDecode(res.body)['products'][i])
     );
     showSnackBar(context, 'Catagory Product');
   });
   return products;
  }

  Future<List<ProductModel>?> fetshSearchProduct(
      { required BuildContext context,required String productName})async{
    List <ProductModel> products=[];
    http.Response res= await http.get(Uri.parse('$uri/product/search/$productName'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      },
    );
    print(jsonDecode(res.body));
    httpErrorHandle(response: res, context: context, onSuccess: (){
      for(int i=0;i<jsonDecode(res.body)['products'].length;i++)
        products.add(
            ProductModel.fromJson(jsonDecode(res.body)['products'][i])
        );
      showSnackBar(context, 'Search Product');
    });
    return products;
  }

  Future<ProductModel?> fetchDealOfDay({
    required BuildContext context
})async{
    ProductModel productModel=ProductModel(
        productName: '',
        description: '',
        quantity: 0,
        images: [],
        catagory: '',
        price: 0,
    );
    try{
      http.Response res=await http.get(Uri.parse('$uri/product/deal-of-day'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
      );
      httpErrorHandle(response: res, context: context, onSuccess: (){
        productModel=ProductModel.fromJson(jsonDecode(res.body));
        print(ProductModel.fromJson(jsonDecode(res.body)));
      });
      
      
    }catch(error){
          print(error.toString());
        }
    return productModel;

  }


}