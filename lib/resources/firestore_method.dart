import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/model/post.dart';
import 'package:instagram_clone/resources/storage_method.dart';

class FirestoreMethod{
  final _firestore= FirebaseFirestore.instance;
  Future<String> upLoad(
    String description,
    Uint8List file,
    String uid,
    String userName,
    
    String profImage,
  
    
    )
    async{
    
    
    var res = "Some error occur";
    try{
        String photoUrl = await StorageMethod().upLoadImage("posts", file, true);
        final postId = Uuid().v1();
      PostModel post =  PostModel(
          description: description, 
          uid: uid, 
          userName: userName, 
          postId: postId, 
          datePublished: DateTime.now(), 
          postUrl: photoUrl, 
          profImage: profImage, 
          like: []);
          _firestore.collection("posts").doc(postId).set(post.toJson());
          res = "success";
    }catch(e){
      res = e.toString();
    }
    return res;
  }
  Future<void> likesPost(String postId, String uid, List likes) async{
     try{
       if(likes.contains(uid)){
       await _firestore.collection("posts").doc(postId).update({
          'like': FieldValue.arrayRemove([uid])
        });
       }else{
       await _firestore.collection("posts").doc(postId).update({
          'like': FieldValue.arrayUnion([uid])
        });
       }
     }catch(e){
      print(e.toString());
     }
  }
}