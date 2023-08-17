import 'package:e_commerce_app/modules/addressScreen/addressScreen.dart';
import 'package:e_commerce_app/modules/cartDetails/cartList.dart';
import 'package:e_commerce_app/modules/search/search.dart';
import 'package:e_commerce_app/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../commponent/common/reusableWidget.dart';
import '../../commponent/constants/globalVariables.dart';
import '../../services/auth_services.dart';

class CartDetailsScreen extends StatefulWidget {
  const CartDetailsScreen({Key? key} ) : super(key: key);

  @override
  State<CartDetailsScreen> createState() => _CartDetailsScreenState();
}

class _CartDetailsScreenState extends State<CartDetailsScreen> {
  final AuthServices authServices=AuthServices();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authServices.getUserData(context: context);

  }



  void navigateToSearchScreen(String query){
    navigateTo(context, SearchScreen(searchQuery: query));
  }

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserProvider>(context,listen: true).user;
    var searchController=TextEditingController();
    int sum=0;
    user.cart?.map((e) => sum+=e['quantity']*e['product']['price'] as int).toList();

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
                      child: defaultTextFormField(onSubmit:navigateToSearchScreen,hintText:'Search Bazer',controller: searchController, type: TextInputType.text, prefixIcon: Icons.search, kind: 'Search')),
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
                Container(
                  margin:EdgeInsets.all(10) ,
                  child: Row(
                    children: [
                      Text('Subtotal ',
                      style: TextStyle(
                        fontSize: 20
                      ),
                      ),
                      Text('\$$sum ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: defaultButton(
                      height: 70,
                      background: Colors.yellow.shade600,
                      color: Colors.black ,
                      text: ' Proceed To Buy (${user.cart?.length} items) ',
                      onpressed: (){
                        navigateTo(context, AddressScreen(totalAmount: sum.toString(),));
                      }),
                ),
                SizedBox(height: 15,),
                MyDivider(),
                SizedBox(height: 5,),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                  itemCount:user.cart?.length ,
                  itemBuilder: (context,index){
                      return ProductList(index: index);
                  }
                )






              ]),
        )
    );
  }

}





