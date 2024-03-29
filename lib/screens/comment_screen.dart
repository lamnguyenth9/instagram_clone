import 'package:flutter/material.dart';
import 'package:instagram_clone/widget/comment_card.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Comments",style: TextStyle(color: Colors.black),),
        centerTitle: false,
      ),
      body: CommentsCard(),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom
          ),
          padding: EdgeInsets.only(left: 16,right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/lam.jpg"),
                radius: 18,
              ),
              SizedBox(width: 10,),
              Expanded(child: 
              TextField(
                decoration: InputDecoration(
                  hintText: "Comment as username",
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none
                ),
              )),
              InkWell(
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                  child: Text("Post",style: TextStyle(
                    color: Colors.blue
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}