import 'package:e_commerce_app/commponent/constants/globalVariables.dart';
import 'package:e_commerce_app/modules/home/homeScreen.dart';
import 'package:e_commerce_app/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modules/AccountScreen/accountScreen.dart';
import '../modules/cartDetails/cartDetails.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);


  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int index1=0;

  List<Widget> pages=[
    HomeScreen(),
    AccountScreen(),
    CartDetailsScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      index1 = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen=context.watch<UserProvider>().user.cart?.length;
    return Scaffold(
      body: pages[index1],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:index1 ,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        onTap: (index){
          setState(() {
            index1=index;
          });
        },
        iconSize: 28,
        items: [
          BottomNavigationBarItem(icon: Container(
            width: 42,
            decoration: BoxDecoration(
              border:Border(top: BorderSide(
                color: index1 ==0 ? GlobalVariables.selectedNavBarColor :GlobalVariables.backgroundColor,
                width:5,
              ))
            ),
            child: Icon(Icons.home_outlined),
          ),label: 'Home'),
          BottomNavigationBarItem(icon: Container(
            width: 42,
            decoration: BoxDecoration(
              border:Border(
                  top: BorderSide(
                color: index1 ==1 ? GlobalVariables.selectedNavBarColor :GlobalVariables.backgroundColor,
                width:5,
              ),
              ),
            ),
            child: Icon(Icons.person_outline_outlined),
          ),label: 'User'),
          BottomNavigationBarItem(icon: Container(
            width: 42,
            decoration: BoxDecoration(
              border:Border(top: BorderSide(
                color: index1 ==2 ? GlobalVariables.selectedNavBarColor :GlobalVariables.backgroundColor,
                width:5,
              ))
            ),
            child:  Badge(
                label: Text(userCartLen.toString(),style: TextStyle(color: Colors.black,fontSize: 14),),
                backgroundColor: Colors.white,
                child: Icon(Icons.shopping_cart_checkout_outlined),
            ),
          ),label: 'Cart'),
        ],
      ),
    );
  }
}
