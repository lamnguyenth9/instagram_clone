import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel{
  
  final String description;
  final String uid;
  final String userName;
  final String postId;
  final  datePublished;
  final String postUrl;
  final String profImage;
  final List like;
  PostModel({
    required this.description,
    required this.uid,
    required this.userName,
    required this.postId,
    required this.datePublished,
    required this.postUrl,required this.profImage,
    required this.like
  });

  Map<String,dynamic> toJson()=>{
        'description':description,
        'uid':uid,
        'userName':userName,
        'postId':postId,
        'datePublished':datePublished,
        'postUrl':postUrl,
        'profImage': profImage,
        'like':like
  };
  static PostModel fromSnapshot(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String,dynamic>;
    return PostModel(
      description: snapshot['description'], 
      uid: snapshot['uid'], 
      userName: snapshot['userName'], 
      postId: snapshot['postId'], 
      datePublished: snapshot['datePublished'], 
      postUrl: snapshot['postUrl'], 
      like: snapshot['like'], profImage:  snapshot['profImage'],

      );
  }
}
