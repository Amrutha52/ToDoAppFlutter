
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ToDoCard extends StatelessWidget
{
  const ToDoCard(
      {super.key,
        this.onDelete,
        required this.title,
        required this.desc,
        required this.date,
        this.onEdit
        });
  final void Function()? onDelete; // cardine akathe ninne deletene listileke konde varan
  final void Function()? onEdit;
  final String title;
  final String desc;
  final String date;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        // image: DecorationImage(image: AssetImage(imageConstants.CARD_BG_PNG,
        // ),
        // fit: BoxFit.cover
        // ),
       // color: noteColor, // notecardil kittunna colorine use cheyanu
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              // For Editing
              IconButton(
                  onPressed: onEdit,
                  icon: Icon(Icons.edit, color: Colors.white)),
              // For Deleting
              IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete, color: Colors.white)),
            ],
          ),
          Text(
            desc,
            maxLines: 4,
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.normal),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                date,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
              // For Sharing
              IconButton(
                  onPressed: () {
                    Share.share("$title \n$desc \n$date"); // Separate data onnum kittenda aavashyam illa athondane evide viliche..
                  },
                  icon: Icon(Icons.share, color: Colors.deepPurpleAccent)),
            ],
          ),
        ],
      ),
    );
  }
}