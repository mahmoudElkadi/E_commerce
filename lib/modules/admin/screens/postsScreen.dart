import 'package:dotted_border/dotted_border.dart';
import 'package:e_commerce_app/commponent/common/reusableWidget.dart';
import 'package:e_commerce_app/commponent/constants/globalVariables.dart';
import 'package:e_commerce_app/model/product.dart';
import 'package:e_commerce_app/services/admin/adminServices.dart';
import 'package:flutter/material.dart';

import 'addProduct.dart';

class PostsScreen extends StatefulWidget {


  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<ProductModel> product=[];
  final AdminServices adminServices=AdminServices();
  @override
  void initState() {
    super.initState();
    getAllProduct();
  }

  void getAllProduct()async {
    product= (await adminServices.fetchAllProducts(context))!;
    setState(() {
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: product == null
           ?Center(child: CircularProgressIndicator(),)
           :Container(
         padding: EdgeInsets.only(top: 15),
             color: GlobalVariables.backgroundColor,
             child: GridView.builder(

              shrinkWrap:true ,
              itemCount: product.length,
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.85),
               itemBuilder:(context,index) {
              final productData=product[index];
             return Column(
               children: [
                 Expanded(
                   child: Container(
                     width: 170,
                     height: 150,
                     decoration: BoxDecoration(
                       border: Border.all(color: Colors.grey.shade300),
                       borderRadius: BorderRadius.circular(10),
                     ),
                     child: Image(image: NetworkImage(productData.images![0].toString()),),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10),
                   child: Row(

                     children: [
                       Expanded(
                         child: Padding(
                           padding: const EdgeInsets.only(left: 8.0),
                           child: Text('${productData.productName}',
                             maxLines: 2,
                             overflow: TextOverflow.ellipsis,
                             style: TextStyle(
                                  fontSize: 16,
                                 fontWeight: FontWeight.w400
                             ),
                           ),
                         ),
                       ),
                       IconButton(onPressed:()=> deleteOneProducts(productData.id as String,index),
                           icon: Icon(Icons.delete_forever_outlined),)
                     ],
                   ),
                 )
               ],
             );
         }
               ),
           ),


      floatingActionButton:FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          navigateTo(context, AddProductScreen());
        },
        tooltip:'Add a Product' ,
      ) ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  deleteOneProducts(String id, int index) {
    adminServices.deleteProduct(
      context: context,
      id:id ,
      onSuccess: () {
        product!.removeAt(index);
        setState(() {});
      },
    );
  }


}
