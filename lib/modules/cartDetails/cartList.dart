import 'package:e_commerce_app/services/user/userServieses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../commponent/common/reusableWidget.dart';
import '../../model/product.dart';
import '../../provider/userProvider.dart';
import '../../services/auth_services.dart';
import '../productDetails/productDetails.dart';

class ProductList extends StatefulWidget {
  final int index;
   ProductList({Key? key,required this.index} ) : super(key: key);



  @override
  State<ProductList> createState() => _ProductListState();

}

class _ProductListState extends State<ProductList> {



  final AuthServices authServices=AuthServices();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authServices.getUserData(context: context);

  }

  final UserServices userServices=UserServices();



  void increaseQuantity(ProductModel productModel){
setState(() {
  userServices.addToCart(context: context, id: productModel.id as String);
});
  }

  void decreaseQuantity(ProductModel productModel){
setState(() {
  userServices.removeFromCart(context: context, id: productModel.id as String);

});
  }




  @override
  Widget build(BuildContext context) {
    final productCart=Provider.of<UserProvider>(context,listen: true).user.cart?[widget.index];
    final product=ProductModel.fromMap(productCart['product']);
    final quantity = productCart['quantity'];


    return Column(
      children: [
        InkWell(
            onTap: () {
              print('sasdass');
              navigateTo(context, ProductDetialsScreen(productModel: product,));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(

                child: Row(
                  children: [
                    Container(
                      height: 135,
                      width: 135,

                      child: Image(image: NetworkImage('${product.images?[0]}'),fit: BoxFit.contain,),
                    ),
                    Column(
                      children: [
                        Container(
                          width:215,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('${product.productName}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18
                            ),
                          ),
                        ),
                        Container(
                          width:215,
                          padding: EdgeInsets.only(left: 10,top: 5),
                          child: rateingProduct(rating: 4),
                        ),
                        Container(
                          width:215,
                          padding: EdgeInsets.only(left: 10,top: 5),
                          child: Text('${product.price} \$',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          width:215,
                          padding: EdgeInsets.only(left: 10,top: 5),
                          child: Text('Eligible for Free Shiping',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,

                            ),
                          ),
                        ),
                        Container(
                          width:215,
                          padding: EdgeInsets.only(left: 10,top: 5),
                          child: Text('In Stock',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 16,
                                fontWeight: FontWeight.w400

                            ),
                          ),
                        ),


                      ],
                    )
                  ],
                ),
              ),
            ),

          ),
        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black12
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap:()=>
                        decreaseQuantity(product),

                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Icon(Icons.remove),
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: Text(quantity.toString()),
                    ),
                    InkWell(
                      onTap:()=>
                        increaseQuantity(product),

                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
