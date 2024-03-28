import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_method.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/resposive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/ultis.dart';
import 'package:instagram_clone/widget/text_field_input.dart';
import 'package:image_picker/image_picker.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool isLoading=false;
 Uint8List? _image;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }
  void selectImage()async{
    Uint8List im=  await pickImage(ImageSource.gallery);
    setState(() {
      _image=im;
    });
  }
  void signUpUser()async{
    setState(() {
      isLoading=true;
    });
    String res = await AuthMethod().signUp(
      email: _emailController.text, 
      password: _passController.text, 
      username: _usernameController.text, 
      bio: _bioController.text, 
      file: _image!);
      if(res =='success'){
        showSnackBar(context, res);
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (_)=>LayoutResponsive(webScreen: WebScreenLayout(), mobileScreen: MobileScreenLayout())
          ));
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
               SizedBox(height: 40,),
               Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: Colors.red,
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://i.stack.imgur.com/l60Hf.png'),
                          backgroundColor: Colors.red,
                        ),
                  Positioned(
                    bottom: -5,
                    left: 80,
                    child: IconButton(
                    onPressed: selectImage, 
                    icon: Icon(Icons.add_a_photo,color: Colors.white,)))
                ],
               ),
               SizedBox(height: 24,),
               TextInput(
                textEditingController: _usernameController, 
                isPass: false, 
                hintText: "Enter your username", 
                textInputType: TextInputType.text),
                SizedBox(height: 24,),
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
                SizedBox(height: 24,),
                 TextInput(
                textEditingController: _bioController, 
                isPass: false, 
                hintText: "Enter your Bio", 
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
                  onTap: () async {
                    String res = await AuthMethod().signUp(
                    email: _emailController.text, 
                    password: _passController.text, 
                    username: _usernameController.text, 
                    bio: _bioController.text, file: _image!,);
                    print(res);
                  },
                  child: InkWell(
                    onTap: signUpUser,
                    child:
                    isLoading
                    ? Center(child: CircularProgressIndicator(color: Colors.white,),) 
                    :Container(
                      child: Text("Sign up"),
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
                ),
                SizedBox(height: 12,),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text("Have acount? ", style: TextStyle(
                        color: Colors.grey
                      ),),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    Container(
                      child: Text("Login", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue
                      ),),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    )
                  ],
                )

          ],
        ),
      )),
    );
  }
}