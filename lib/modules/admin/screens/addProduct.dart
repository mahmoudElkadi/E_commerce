import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:e_commerce_app/commponent/constants/utiles.dart';
import 'package:e_commerce_app/services/admin/adminServices.dart';
import 'package:flutter/material.dart';

import '../../../commponent/common/reusableWidget.dart';
import '../../../commponent/constants/globalVariables.dart';

class AddProductScreen extends StatefulWidget {

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var productController=TextEditingController();

  var descriptionController=TextEditingController();

  var priceController=TextEditingController();

  var quantityController=TextEditingController();

  final ProductGlobalKey=GlobalKey<FormState>();


  AdminServices adminServices=AdminServices();

  List<String> ProductCatagories=[
    "Mobiles",
    'Essentials',
    'Applinces',
    'Books',
    "sports"
  ];
  String? catagory;
  List<File> images=[];

  void selectImages()async{
    var result=await pichImages();
    setState(() {
        images=result;
    });
  }

  void sellProduct(){
    if(ProductGlobalKey.currentState!.validate()&&images.isNotEmpty){
      adminServices.sellProduct(context: context, productName: productController.text, description: descriptionController.text, price: int.parse(priceController.text), quantity: int.parse(quantityController.text), catagory: catagory??'Mobiles', images: images);
    }
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:const Size.fromHeight(50),
        child:AppBar(
          flexibleSpace:Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ) ,
          title:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 70),
                child: Text("Add Product",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black
                ),),
              )
            ],
          ) ,
        ) ,
      ),
        body: SingleChildScrollView(
          child: Form(
            key: ProductGlobalKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  images.isNotEmpty?
                  CarouselSlider(
                    items: images.map((i)=>Builder(
                      builder:(context)=> Image.file(
                        i,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )).toList(),
                    options: CarouselOptions(
                        height: 250,
                        viewportFraction: 1,

                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(seconds:1),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal
                    ),
                  )
                  :GestureDetector(
                    onTap:selectImages,
                    child: DottedBorder(
                      color: Colors.grey,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(10),
                        dashPattern: [10,4],
                        strokeCap: StrokeCap.round,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.folder_open,size: 40,),
                              SizedBox(height: 15,),
                              Text('Select Product images',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(height: 15,),
                  Container(child: TextFormField2(controller: productController, type: TextInputType.text,  kind: 'Product',hintText: 'Product Name')),
                  SizedBox(height: 20,),
                  Container(child: TextFormField2(controller: descriptionController, type: TextInputType.text,  kind: 'Description',hintText: 'Description',maxLines: 7)),
                  SizedBox(height: 20,),
                  Container(child: TextFormField2(controller: priceController , type: TextInputType.text,  kind: 'Price',hintText: 'Price')),
                  SizedBox(height: 20,),
                  Container(child: TextFormField2(controller: quantityController, type: TextInputType.text,  kind: 'Quantity',hintText: 'Quantity')),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      value: catagory??'Mobiles',
                      onChanged: (value) {
                        setState(() {
                          catagory=value!;
                        });
                      },
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: ProductCatagories.map((i) {
                       return DropdownMenuItem(
                              value: i,
                              child: Text(i),);
                      }).toList(),

                    ),
                  ),
                  SizedBox(height: 20,),
                  defaultButton( height: 60,
                    text: 'Sell',
                    onpressed:(){
                      sellProduct();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
