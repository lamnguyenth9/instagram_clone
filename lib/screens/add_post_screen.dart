import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/model/user.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/resources/firestore_method.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/ultis.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  bool isLoading=false;
  TextEditingController _descriptionController = TextEditingController();
  void clearImage(){
    setState(() {
      _file=null;
    });
  }
 void postImage(
    {
    required  String uid,
   required String userName,
   required String profImage
    }
  )async{
    setState(() {
        isLoading=true;
      });
    try{
      
       final res = await FirestoreMethod().upLoad(
        _descriptionController.text, 
        _file!, 
        uid, 
        userName, 
      
        profImage, 
      );
      if(res == "success"){
        
        setState(() {
          isLoading=false;
  
        });
       if(context.mounted){
        showSnackBar(context, "Posted");
       }
        
        clearImage();
      }else{
        showSnackBar(context, res);
      }
    }catch(e){
           showSnackBar(context, e.toString());
    }
  }
  selectedImage(BuildContext context)async{
    return showDialog(context: context, builder: (_){
      return SimpleDialog(
        title: Text("Create a Post"),
        children: [
          SimpleDialogOption(
            padding: EdgeInsets.all(20),
            child: Text("Take a photo"),
            onPressed: ()async{
              Navigator.pop(context);
              Uint8List file = await pickImage(ImageSource.camera);
              setState(() {
                _file=file;
              });
            },
          ),
          SimpleDialogOption(
            padding: EdgeInsets.all(20),
            child: Text("Choose a gallery"),
            onPressed: ()async{
              Navigator.pop(context);
              Uint8List file = await pickImage(ImageSource.gallery);
              setState(() {
                _file=file;
              });
            },
          ),
          SimpleDialogOption(
            padding: EdgeInsets.all(20),
            child: Text("Cancel"),
            onPressed: ()async{
              Navigator.pop(context);
              
            },
          )
        ],
      );
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final UserProvider user = Provider.of<UserProvider>(context);
    
    final size = MediaQuery.of(context).size;
   return _file==null?
     Center(child: 
     IconButton(
      onPressed: (){selectedImage(context);}, 
      icon: Icon(Icons.upload)))
    : Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Post",style: TextStyle(color: Colors.black),),
        leading: IconButton(
          onPressed: clearImage, 
          icon: Icon(Icons.arrow_back,color: Colors.black,)),
        actions: [
          TextButton(onPressed:()=> postImage(uid: user.getUser.uid, userName: user.getUser.username, profImage: user.getUser.photoUrl), child: 
          Text("post",style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),))
        ],
      ),
      body: Column(children: [
        isLoading? 
        LinearProgressIndicator()
        :Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.getUser.photoUrl),
            ),
            SizedBox(
              width: size.width*0.3,
              child: TextField(
                controller: _descriptionController,
                   style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  
                  hintText: "write a caption...",
                  hintStyle: TextStyle(
                    color: Colors.black
                  ),
                  border: InputBorder.none,
                  
                ),
                maxLines: 8,
              ),
            ),
            SizedBox(
              height: 45,
              width: 45,
              child: AspectRatio(
                aspectRatio: 487/451,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(_file!),
                      fit: BoxFit.fill,
                      alignment: FractionalOffset.topCenter
                    )
                  ),
                ),
              ),
            )
          ],
        )
      ],),
    );
  }
}