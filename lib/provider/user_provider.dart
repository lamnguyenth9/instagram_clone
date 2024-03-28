import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/model/user.dart';
import 'package:instagram_clone/resources/auth_method.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier{
  UserModel? _user;
  final AuthMethod _auth = AuthMethod();
  UserModel get getUser => _user!;
  Future<void> refreshUser() async {
    UserModel user = await  _auth.getUserDetail();
    _user = user;
    notifyListeners();
  }
}