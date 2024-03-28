import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_method.dart';

import 'package:instagram_clone/screens/sign_up_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/ultis.dart';
import 'package:instagram_clone/widget/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/resposive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool isLoading =false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }
  void loginUser()async{
    setState(() {
      isLoading=true;
    });
    final res = await AuthMethod().login(email: _emailController.text, password: _passController.text);
    if(res=='success'){
     showSnackBar(context, res);
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (_)=>LayoutResponsive(webScreen: WebScreenLayout(), mobileScreen: MobileScreenLayout())
          ));
    }else{
      showSnackBar(context, res);
    }
    setState(() {
      isLoading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
             //svg assets 
               SvgPicture.asset("assets/ic_instagram.svg",color: Colors.black,height: 64,),
               SizedBox(height: 64,),
               
               TextInput(
                textEditingController: _emailController, 
                isPass: false, 
                hintText: "Enter your email", 
                textInputType: TextInputType.emailAddress),
                SizedBox(height: 24,),
              TextInput(
                textEditingController: _passController, 
                isPass: true, 
                hintText: "Enter your password", 
                textInputType: TextInputType.text),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Forgot password?",style: TextStyle(
                      color: Colors.blue,

                    ),)
                  ],
                ),
                SizedBox(height: 24,),
                InkWell(
                  onTap: loginUser,
                  child: Container(
                    child: 
                    isLoading
                    ? Center(child: CircularProgressIndicator(),)
                    : Text("Login"),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      color: blueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)
                      )
                      ),
                  ),
                ),
                SizedBox(height: 12,),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text("Don't have acount? "),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUpScreen()));
                      },
                      child: Container(
                        child: Text("Sign up", style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),),
                        padding: EdgeInsets.symmetric(vertical: 8),
                      ),
                    )
                  ],
                )

          ],
        ),
      )),
    );
  }
}