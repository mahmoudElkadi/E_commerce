import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/commponent/common/reusableWidget.dart';
import 'package:e_commerce_app/commponent/constants/globalVariables.dart';
import 'package:e_commerce_app/model/product.dart';
import 'package:e_commerce_app/modules/search/search.dart';
import 'package:e_commerce_app/provider/userProvider.dart';
import 'package:e_commerce_app/services/product/productServies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../categories/categories.dart';
import '../productDetails/productDetails.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToSearchScreen(String query){
    navigateTo(context, SearchScreen(searchQuery: query));
  }

  ProductModel? productModel;
  ProductServies productServies=ProductServies();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();

  }
  fetchDealOfDay()async{
productModel =await productServies.fetchDealOfDay(context: context);
setState(() {
print(productModel);
});
  }

  @override
  Widget build(BuildContext context) {
    List <String> category=["Mobiles",
      'Essentials',
      'Applinces',
      'Books',
      "sports"];

    var searchController=TextEditingController();
    final user=Provider.of<UserProvider>(context).user;
    return
    productModel==null?
        Center(child: CircularProgressIndicator(),):
    Scaffold(
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
      body: SingleChildScrollView(
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
                   'Delivery to ${user.userName},${user.address} ',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                  ))
              ],),
            ),
            SizedBox(height: 15,),
            Container(
              padding: EdgeInsets.only(left: 10),
              height: 60,
              width: double.infinity,

              child: ListView.builder(
                scrollDirection: Axis.horizontal,

                  itemBuilder: (context,index)=>Column(
                    children: [
                      InkWell(
                        onTap:(){
                          navigateTo(context, CategoriesScreen(category:category[index] ,));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Image(
                              image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_iiQOrfwLX67n0c29ShBYEzBaaiwJ8zBw0A&usqp=CAU',)
                              ,fit: BoxFit.fitHeight,
                              height: 40,
                              width: 50,
                              )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('${category[index]}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                        ),),
                      )
                    ],
                  ),

                itemCount: 5,
              ),
            ),
            SizedBox(height: 15,),
            CarouselSlider(
                items: GlobalVariables.carouselImages.map((i)=>ClipRRect(
                  child: Image(
                    image: NetworkImage('${i}'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )).toList(),
                options: CarouselOptions(
                    height: 200,
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
            ),
            GestureDetector(
              onTap: (){
                navigateTo(context, ProductDetialsScreen(productModel: productModel,));
              },
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10,top:15,bottom: 15),
                    child: Text(
                      'Deal of the day',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Image(image:
                    NetworkImage('${productModel!.images?[0]}'),
                  fit: BoxFit.fitHeight,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15,),
                alignment: Alignment.topLeft,
                child: Text(
                  '\$ ${productModel!.price}',
                  style: TextStyle(
                    fontSize: 18,
                   ),

                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 15,top:5,right: 40),
                child:Text('${productModel!.productName}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight:FontWeight.w500,
                  fontSize: 16
                ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:productModel?.images !=null ? productModel!.images!.map((e) =>
                      Image(image:NetworkImage(e),
                        fit: BoxFit.fitWidth,
                        width: 100,
                        height: 100,),
                  ).toList():[Text("sdasdas")]


                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15),
                alignment: Alignment.topLeft,
                child: Text('See all deals',style: TextStyle(
                  color: Colors.cyan[800],
                  fontSize: 15
                ),),
              )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
