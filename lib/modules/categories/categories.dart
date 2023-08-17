import 'package:e_commerce_app/commponent/common/reusableWidget.dart';
import 'package:e_commerce_app/modules/productDetails/productDetails.dart';
import 'package:e_commerce_app/services/product/productServies.dart';
import 'package:flutter/material.dart';

import '../../commponent/constants/globalVariables.dart';
import '../../model/product.dart';

class CategoriesScreen extends StatefulWidget {
  String? category;
  
  

   CategoriesScreen( {
  Key? key,
  required this.category}):super(key:key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List <ProductModel>? products;
  final ProductServies productServies=ProductServies();
  @override
  void initState() {
    super.initState();
    getProduct();
  }

  void getProduct()async{
    products=await productServies.fetshCategoryProduct(
        context:context,
        category:widget.category as String);
    setState(() {
print('sfdasfasfasfasfasf$products');
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
              gradient:GlobalVariables.appBarGradient,
            ),
          ) ,
          title:Text(widget.category as dynamic,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),),
        ) ,
      ),
      body:products==null?
          Center(child: CircularProgressIndicator(),)
      :Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            alignment: Alignment.topLeft,
            child: Text('Keep Shoping for ${widget.category}',
            style: TextStyle(
              fontSize: 20,
            ),
            ),
          ),
          SizedBox(
            height: 170,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 15),
              itemCount: products?.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.4,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                ProductModel productData=products![index];
                return InkWell(
                  onTap: () {
                    print('sasdass');
                    navigateTo(context, ProductDetialsScreen(productModel: productData,));
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 130,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                              width: 0.5,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.network(
                              '${productData.images![0]}',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(
                          left: 0,
                          top: 5,
                          right: 15,
                        ),
                        child: Text(
                          '${productData.productName}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

        ],
      )
      );


  }
}
