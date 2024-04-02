import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class CommentsCard extends StatefulWidget {
  final snap;
  const CommentsCard({super.key, required this.snap});

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
            backgroundImage: AssetImage(widget.snap['profilePic']),
          ),
          Expanded(
            child: Padding(padding: EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.snap['name'],
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)
                      ),
                      TextSpan(
                        text: "  ",
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)
                      ),
                      TextSpan(
                        text: widget.snap['text'],
                        style: TextStyle(color: Colors.black)
                      )
                    ]
                  )
                  ),
                  Padding(padding: EdgeInsets.only(top: 4),
                  child: Text( DateFormat.yMMMd()
                        .format(widget.snap['datePublished'].toDate()),style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                  ),),),
                  
              ],
            ),),
          ),
          Container(
                  height: 30,
                  width: 30,
                  padding: EdgeInsets.all(4),
                  child: Image.asset("assets/heart.png",)
                )
        ],
      ),
    );
  }
}