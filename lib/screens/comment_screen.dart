import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/model/user.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/resources/firestore_method.dart';
import 'package:instagram_clone/widget/comment_card.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {

  final snap;
  const CommentScreen({super.key,required this.snap});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Comments",style: TextStyle(color: Colors.black),),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').doc(widget.snap['postId']).collection('comments').orderBy('datePublished',descending: true).snapshots(), 
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) {
              return CommentsCard(
                snap: (snapshot.data! as dynamic).docs[index],
              );
            },
            );
        },),
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
                backgroundImage: AssetImage(userModel.photoUrl),
                radius: 18,
              ),
              SizedBox(width: 10,),
              Expanded(child: 
              TextField(style: TextStyle(color: Colors.black),
                controller: text,
                
                decoration: InputDecoration(
                  
                  hintText: "Comment as ${userModel.username}",
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none
                ),
              )),
              InkWell(
                onTap: ()async{
                  await FirestoreMethod().PostComment(widget.snap['postId'], text.text, userModel.uid, userModel.username, userModel.photoUrl);
                  setState(() {
                    text.text="";
                  });
                },
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