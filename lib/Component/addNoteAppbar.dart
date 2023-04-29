import 'package:flutter/material.dart';

class AddNoteAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => new Size.fromHeight(AppBar().preferredSize.height);
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
          backgroundColor: Color(0xFF6034A6),
          foregroundColor: Colors.white,
          // title: Text("Notes"),
          leading: IconButton(
            onPressed: () {
              
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 25),
          ),
          actions: [
            Container(alignment: Alignment.center,
            padding: EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: (){},
                child: Text("Save", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.white))
              ),
            )
          ],
        );
  }
}