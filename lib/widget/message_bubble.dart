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
        constraints: const BoxConstraints(
          minHeight: 20
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.end,
             children: [
            Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 160,
                ),
                child: Text(
                  chatContent,
                 // maxLines: 10,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    color: textColor,
                  fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
               const SizedBox(width: 5,),
                Container(
                // margin: const EdgeInsets.only(top: 15),
                 alignment: Alignment.bottomRight,
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
