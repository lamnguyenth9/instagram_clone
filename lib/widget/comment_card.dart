import 'package:flutter/material.dart';

class CommentsCard extends StatefulWidget {
  const CommentsCard({super.key});

  @override
  State<CommentsCard> createState() => _CommentsCardState();
}

class _CommentsCardState extends State<CommentsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/lam.jpg"),
          ),
          Padding(padding: EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "User Name  ",
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)
                    ),
                    TextSpan(
                      text: "some description",
                      style: TextStyle(color: Colors.black)
                    )
                  ]
                )
                ),
                Padding(padding: EdgeInsets.only(top: 4),
                child: Text("29/3/2024",style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black
                ),),)
            ],
          ),)
        ],
      ),
    );
  }
}