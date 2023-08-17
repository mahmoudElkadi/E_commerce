import 'dart:convert';

import 'package:e_commerce_app/model/rating.dart';




class ProductModel{
  String? productName;
  String? description;
  int? price;
  int? quantity;
  String? catagory;
  List<dynamic>? images;
  String? id;
   List<Rating>? rating;

  ProductModel({
    this.productName,
    this.description,
    this.price,
    this.quantity,
    this.catagory,
    this.images,
    this.id,
     this.rating,
  });

  factory ProductModel.fromMap(Map<String,dynamic> json){
    return ProductModel(
      productName:json['productName'],
      description:json['description'],
      price:json['price'],
      quantity:json['quantity'],
      catagory:json['catagory'],
      images:json['images'],
      id:json['_id'],
      rating:json['rating'],
    );
  }

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'productName':productName,
      'description':description,
      'price':price,
      'quantity':quantity,
      'catagory':catagory,
      'images':images,
      'rating':rating,
    };
  }

  String toJson()=>json.encode(toMap());
  //factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));

  ProductModel.fromJson(Map<String,dynamic>json){
    id = json['_id'];
    productName = json['productName'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    catagory = json['catagory'];
    images = json['images'];
    rating = json['rating'];
  }
}





//
// class Product{
//   String? productName;
//   String? description;
//   int? price;
//   int? quantity;
//   String? catagory;
//   List<dynamic>? images;
//   String? id;
//   List<Rating>? rating;
//
//   Product({
//     this.productName,
//     this.description,
//     this.price,
//     this.quantity,
//     this.catagory,
//     this.images,
//     this.id,
//     this.rating,
//   });
//
//   factory Product.fromMap(Map<String,dynamic> json){
//     return Product(
//       productName:json['productName'],
//       description:json['description'],
//       price:json['price'],
//       quantity:json['quantity'],
//       catagory:json['catagory'],
//       images:json['images'],
//       id:json['_id'],
//       rating:json['rating'],
//     );
//   }
//
//   Map<String,dynamic> toMap(){
//     return{
//       'id':id,
//       'productName':productName,
//       'description':description,
//       'price':price,
//       'quantity':quantity,
//       'catagory':catagory,
//       'images':images,
//       'rating':rating,
//     };
//   }
//
//   String toJson()=>json.encode(toMap());
//   //factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));
//
//   factory Product.fromJson(String source) => Product.fromMap(json.decode(source));
//
// }