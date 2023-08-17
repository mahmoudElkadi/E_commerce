import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/model/product.dart';
import 'package:e_commerce_app/provider/userProvider.dart';
import 'package:e_commerce_app/services/product/productDetailsServices.dart';
import 'package:e_commerce_app/services/user/userServieses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../commponent/common/reusableWidget.dart';
import '../../commponent/constants/globalVariables.dart';
import '../search/search.dart';

class ProductDetialsScreen extends StatefulWidget {
  final ProductModel? productModel;

  const ProductDetialsScreen({
    Key? key,
    required this.productModel}):super(key:key);


  @override
  State<ProductDetialsScreen> createState() => _ProductDetialsScreenState();
}

class _ProductDetialsScreenState extends State<ProductDetialsScreen> {
double avgRating=0;
double myRating=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.productModel);
    double totalRating=0;
    if(widget.productModel?.rating !=null)

    for(int i=0;i<widget.productModel!.rating!.length;i++){
      totalRating+=widget.productModel!.rating![i].rating;
      print(totalRating);
      if(widget.productModel?.rating![i].userId==Provider.of<UserProvider>(context,listen: false).userModel.id){
         myRating=widget.productModel!.rating![i].rating;
      }
    }

    if(totalRating!=0){
      avgRating=totalRating/widget.productModel!.rating!.length;
      print('avgRating=$avgRating');
    }
  }

  var searchController=TextEditingController();
  void navigateToSearchScreen(String query){
    navigateTo(context, SearchScreen(searchQuery: query));
  }
final ProductDetailsServices productDetailsServices=ProductDetailsServices();

  final UserServices userServices=UserServices();

  void addToCart(){
    userServices.addToCart(
        context: context,
        id: widget.productModel?.id as String
    );
    print('mmmmmmmmmmmm${widget.productModel?.id as String}');
  }
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.productModel?.id! as String),
                  rateingProduct(rating: avgRating)
                ],
              ),
            ),
            Padding(
              padding:EdgeInsets.symmetric(vertical: 20,horizontal: 10),
              child: Text(widget.productModel?.productName as String,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500
              ),
              ),
            ),

            CarouselSlider(items: widget.productModel!.images?.map(
                (e){
                  return Builder(builder: (context)=> Container(
                    width: double.infinity,
                    height: 350,
                    child: Image(image: NetworkImage(widget.productModel?.images![0]),fit: BoxFit.fitHeight,),
                  ),
                  );

            }).toList(),
                options: CarouselOptions(
                    height: 300,
                    viewportFraction: 1,

                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds:1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal
                ),),
            Container(
              width: double.infinity,
              height: 7,
              decoration: BoxDecoration(
                color: Colors.black12
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text('Deal Price: ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  Text('\$${widget.productModel?.price}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.red
                  ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                widget.productModel?.description as String
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: double.infinity,
              height: 7,
              decoration: BoxDecoration(
                  color: Colors.black12
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: defaultButton(text: 'Buy Now', onpressed: (){}),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: defaultButton(color: Colors.black,
                  background: Colors.yellow,
                  text: 'Add to Cart',
                  onpressed: (){
                    addToCart();
                  }),
            ),
            Container(
              width: double.infinity,
              height: 7,
              decoration: BoxDecoration(
                  color: Colors.black12
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Rate The Product',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              ),
            ),
            RatingBar.builder(
                initialRating: myRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context,index)=>Icon(Icons.star,color: GlobalVariables.secondaryColor,),
                onRatingUpdate: (rating){
                    productDetailsServices.rateProduct(
                        context: context,
                        id: widget.productModel?.id as String,
                        rating: rating);
                    print(widget.productModel?.id );
                    print(rating);
                })

          ],
        ),
      ),
    );
  }
}
