import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key,
  required this.color,
    required this.chatContent,
    required this.textColor,
    required this.timestamp
  });
final Color color;
final String chatContent;
final Color textColor;
final String timestamp;
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.fromLTRB(10,5 , 10, 5),
       margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
      ),
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chatContent,

              maxLines: 10,
              //textAlign: TextAlign.left,
              style: TextStyle(
                overflow: TextOverflow.visible,
                color: textColor,
              fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(width: 2,),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child:  Text(
                DateFormat('hh:mm a').format(
                  DateTime.fromMillisecondsSinceEpoch(
                    int.parse(timestamp),
                  ),),
               // timestamp,
                textAlign: TextAlign.end,
                style:  TextStyle(
                    color: textColor,
                  fontSize: 10
                ),
              ),
            ),
          ],
        ),
    );
  }
}
