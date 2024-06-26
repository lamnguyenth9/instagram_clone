import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  
  final String email;
  final String uid;
  final String photoUrl;
  final String bio;
  final String username;
  final List followers;
  final List following;
  UserModel({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following
  });

  Map<String,dynamic> toJson()=>{
        'username':username,
        'uid':uid,
        'email':email,
        'bio':bio,
        'followers':followers,
        'following':following,
        'photoURL': photoUrl
  };
  static UserModel fromSnapshot(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String,dynamic>;
    return UserModel(
      email: snapshot['email'], 
      uid: snapshot['uid'], 
      photoUrl: snapshot['photoURL'], 
      username: snapshot['username'], 
      bio: snapshot['bio'], 
      followers: snapshot['followers'], 
      following: snapshot['following']);
  }
}
