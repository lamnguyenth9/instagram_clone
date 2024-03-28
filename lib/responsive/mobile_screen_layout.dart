import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global.dart';
import 'package:provider/provider.dart';
import '../model/user.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
  void navigationTappted(int page){
      pageController.jumpToPage(page);
  }
  void onPageChanged(int page){
    setState(() {
      _page=page;
    });
  }
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: PageView(
        children: homeScreenItem,
        physics: NeverScrollableScrollPhysics(),
       controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home,
              color: _page==0?Colors.black:Colors.grey,), label: '', backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.search,color: _page==1?Colors.black:Colors.grey,),
              label: '',
              backgroundColor: primaryColor),
         
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle,color: _page==2?Colors.black:Colors.grey,),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite,color: _page==3?Colors.black:Colors.grey,),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,color: _page==4?Colors.black:Colors.grey,),
              label: '',
              backgroundColor: primaryColor)
        ],
        onTap: navigationTappted,
      ),
    );
  }
}
