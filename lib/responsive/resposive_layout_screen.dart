import 'package:flutter/material.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:provider/provider.dart';

class LayoutResponsive extends StatefulWidget {
  final Widget webScreen;
  final Widget mobileScreen;
  const LayoutResponsive({super.key, required this.webScreen, required this.mobileScreen});

  @override
  State<LayoutResponsive> createState() => _LayoutResponsiveState();
}

class _LayoutResponsiveState extends State<LayoutResponsive> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }
  addData()async{
    UserProvider _userProvider = Provider.of(context,listen: false);
    await _userProvider.refreshUser();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth>600){
          return widget.webScreen;
        }else {return widget.mobileScreen;}
      },
      );
  }
}