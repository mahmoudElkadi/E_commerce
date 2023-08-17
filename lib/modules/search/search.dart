import 'package:flutter/material.dart';

import '../../commponent/common/reusableWidget.dart';
import '../../commponent/constants/globalVariables.dart';
import '../../model/product.dart';
import '../../services/product/productServies.dart';
import '../productDetails/productDetails.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key,required this.searchQuery}) : super(key: key);
  final String searchQuery;


  @override
  State<SearchScreen> createState() => _SearchScreenState();
}


class _SearchScreenState extends State<SearchScreen> {

  List <ProductModel>? products;
  final ProductServies productServies=ProductServies();
  @override
  void initState() {
    super.initState();
    getProduct();
  }

  void getProduct()async{
    products=await productServies.fetshSearchProduct(
        context:context,
        productName:widget.searchQuery as String);
    setState(() {

    });
  }

  var searchController=TextEditingController();
  void navigateToSearchScreen(String query){
    navigateTo(context, SearchScreen(searchQuery: query));
  }
  double? rating;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:const Size.fromHeight(60),
          child:AppBar(
            flexibleSpace:Container(
              decoration: BoxDecoration(
                  gradient: GlobalVariables.appBarGradient
              ),
            ) ,
            title: Row(
              children: [
                Expanded(
                  child: Container(
                      height: 42,
                      child: defaultTextFormField(onSubmit: navigateToSearchScreen,hintText:'Search Bazer',controller: searchController, type: TextInputType.text, prefixIcon: Icons.search, kind: 'Search')),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: IconButton(onPressed: (){}, icon:Icon(Icons.mic)),
                ),
              ],
            ),
          )  ,
        ),
      body:products ==null?
          Center(child: CircularProgressIndicator(),)
      :SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              height: 40,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 125, 221, 216),
                  Colors.purpleAccent
                ],
                    stops: [0.5,1.0]
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined,size: 25,),
                  SizedBox(width: 5,),
                  Expanded(child: Text(
                    'Delivery to ',
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                  ))
                ],),
            ),
            SizedBox(height: 15,),
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index) {
                var productData=products![index];
                 return builtProductItem(productData);
                }, separatorBuilder:(context,int)=>SizedBox(height: 15,), itemCount: products!.length),
            SizedBox(height: 20,)

          ],
        ),
      )
    );
  }
  Widget builtProductItem(ProductModel model){
    return InkWell(
      onTap: () {
        print('sasdass');
        navigateTo(context, ProductDetialsScreen(productModel: model,));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
              Container(
                height: 135,
                width: 135,

                child: Image(image: NetworkImage('${model.images![0]}'),fit: BoxFit.contain,),
              ),
              Column(
                children: [
                  Container(
                    width:215,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('${model.productName}',
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
                    child: Text('${model.price} \$',
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
    );
  }
}
