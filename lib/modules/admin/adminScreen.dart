import 'package:flutter/material.dart';
import '../../commponent/constants/globalVariables.dart';
import 'screens/postsScreen.dart';

class AdminScreen extends StatefulWidget {

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {

  int index1=0;

  List<Widget> pages=[
    PostsScreen(),
    Center(child: Text('sss page'),),
    Center(child: Text('cccc page'),),
  ];


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
          title:Align(alignment: AlignmentDirectional.topStart,child: Image.asset('assets/images/bb.png',width: 120,height:45,color: Colors.black,)),

          actions: [
           Padding(
             padding: const EdgeInsets.only(top: 15,right: 25),
             child: Text('Admin',
             style: TextStyle(
               fontSize: 22,
               fontWeight: FontWeight.bold,
               color: Colors.black
             ),),
           ),
          ],
        ) ,
      ),
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
        ),label: ''),
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
          child: Icon(Icons.analytics_outlined),
        ),label: ''),
        BottomNavigationBarItem(icon: Container(
          width: 42,
          decoration: BoxDecoration(
              border:Border(top: BorderSide(
                color: index1 ==2 ? GlobalVariables.selectedNavBarColor :GlobalVariables.backgroundColor,
                width:5,
              ))
          ),
          child: Icon(Icons.inbox_outlined),
        ),label: ''),
      ],
    ),
    );
  }
}
