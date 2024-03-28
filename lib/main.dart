import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/resposive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:provider/provider.dart';


import 'screens/login_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCf_nR4fOmhGeuXortuMVyfVNRhXo6tLng", 
      appId: "1:253591398204:web:e88392b94030afd2602039", 
      messagingSenderId: "253591398204", 
      projectId: "instagram-clone-8d6e8",
      storageBucket: "instagram-clone-8d6e8.appspot.com"
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>UserProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.white
        ),
        // home: LayoutResponsive(webScreen: WebScreenLayout(), mobileScreen: MobileScreenLayout()),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(), 
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.active){
              if(snapshot.hasData){
                return LayoutResponsive(webScreen: WebScreenLayout(), mobileScreen: MobileScreenLayout());
              } else if(snapshot.hasError){
                 return Center(child: Text(snapshot.error.toString()),);
              }
            }
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            return LoginScreen();
          },),
      ),
    );
  }
}

