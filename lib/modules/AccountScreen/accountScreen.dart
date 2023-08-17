import 'package:e_commerce_app/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../commponent/common/reusableWidget.dart';
import '../../commponent/constants/globalVariables.dart';

class AccountScreen extends StatefulWidget {

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserProvider>(context).user.userName;
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
             children: [
               Container(
                 alignment: Alignment.topLeft,
                 child: Image.asset('assets/images/bb.png',width: 120,height:45,color: Colors.black,),
               )
             ],
           ) ,
             actions: [
               IconButton( onPressed: () {  }, icon: Icon(Icons.notifications_none),),

               Container(
                 padding: EdgeInsets.only(right: 15),
                 child: IconButton( onPressed: () {  }, icon: Icon(Icons.search),),
               )
             ],
        )  ,
      ),
      body: Column(
        children: [
           Container(
             width: double.infinity,
             decoration: BoxDecoration(
               gradient: GlobalVariables.appBarGradient,
             ),
             padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
             child: RichText (
               text: TextSpan(
                 text:'Hello, ',
                 style: TextStyle(
                   fontSize: 22,
                   color: Colors.black
                 ),
                 children: [
                   TextSpan(
                   text:'$user ',
                   style: TextStyle(
                       fontSize: 22,
                       color: Colors.black
                   ),
                   )]
               ),
             ),
           ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    defaultOutLineButton(text: 'Your Orders', onpressed: () {  }),
                    defaultOutLineButton(text: 'Turn Seller', onpressed: (){})
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    defaultOutLineButton(text: 'Log Out', onpressed: () {  }),
                    defaultOutLineButton(text: 'Your Wish List', onpressed: (){})
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 15,),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Text('Your Orders',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                    ),),
                    Spacer(),
                    defaultTextButton(function: (){}, text: 'See all')
                  ],
                ),
              ),
              Container(
                height: 170,
                padding: EdgeInsets.only(left: 10,top: 20,right: 0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                    return Container(
                      padding:EdgeInsets.symmetric(horizontal: 5) ,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border:Border.all(color: Colors.black12,width: 1.5),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white
                        ),
                        child: Container(
                          width: 180,
                          padding: EdgeInsets.all(10),
                          child: Image(
                            image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWHpgB8AGJRDn5ML7mMpq2NYMOG9A-xT4ITQ&usqp=CAU'),
                            fit: BoxFit.fitHeight,
                            width: 180,
                          ),
                        ),
                      ),
                    );
                },
                  itemCount: 5,

                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
