import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:instagram_clone/model/user.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatelessWidget {
  final snap;
  const PostCard({super.key,required this.snap});

  @override
  
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4,horizontal: 16).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                   snap['profImage']
                  ),
                  
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snap['userName'],style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                  )
                  ),
                  IconButton(
                    onPressed: (){
                      showDialog(context: context, builder: (_)=>Dialog(
                        child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          children: [
                            'delete'
                          ].map((e) => InkWell(
                            onTap: (){},
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                              child: Text(e),
                            ),
                          )).toList(),
                        ),
                      ));
                    }, 
                    icon: Icon(Icons.more_vert, color: Colors.black,))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.width*0.35,
              width: double.infinity,
              child: Image.network(snap['postUrl'].toString(),fit: BoxFit.cover,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0,top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  child: Container(
                    height: 23,
                    width: 23,
                    child: Image.asset("assets/heart.png")),
                ),
                SizedBox(width: 10,),
                InkWell(
                  child: Container(
                    height: 23,
                    width: 23,
                    child: Image.asset("assets/chat.png")),
                ),
                SizedBox(width: 10,),
                InkWell(
                  child: Container(
                    height: 23,
                    width: 23,
                    child: Image.asset("assets/send.png")),
                ),
                Expanded(child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed:(){} ,
                   icon: Icon(Icons.bookmark_border, color: Colors.black,)),
                ))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: [
                Text("${snap['like'].length} likes", style: TextStyle(
                  color: Colors.black
                ),),
                 Container(
              padding: EdgeInsets.only(top: 8),
              width: double.infinity,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: 
                  [
                    TextSpan(
                      text: snap["userName"],
                      style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                     TextSpan(
                      text: snap['description'],
                 
                    )
                  ]
                )
                ),
            ),
         
           InkWell(
            onTap: (){},
             child: Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text("View all 200 comments", style: TextStyle(
                  color: secondaryColor,
                  fontSize: 16
                ),),
              ),
           ),
           Container(
                
                child: Text(
                  DateFormat.yMMMd().format(snap['datePublished'].toDate())
                 , style: TextStyle(
                  color: secondaryColor,
                  fontSize: 16
                ),),
              ),
          
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}