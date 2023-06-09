import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class Info extends StatefulWidget {
  final String title;
  final String content;
  bool show;
  Info({
    required this.title,
    required this.content,
    required this.show,
    super.key
  });
  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {

  changeIcon(){
    if(widget.title == "Username"){
      return Icon(Icons.person, color: Color(0xFF6034A6), size: 45.r);
    }
    if(widget.title == "Email"){
      return Icon(Icons.email, color: Color(0xFF6034A6), size: 45.r);
    }
    if(widget.title == "Password"){
      return Icon(Icons.lock_person, color: Color(0xFF6034A6), size: 45.r);
    }
    else{
      return Icon(Icons.person, color: Color(0xFF6034A6), size: 45.r);
    }
  }
  
  Icon visibleIcon = Icon(Icons.remove_red_eye_outlined, color: Colors.white, size: 30.r);
  Icon hiddenIcon = Icon(Icons.remove_red_eye, color: Color(0xFF6034A6), size: 30.r);
  late Icon activeIcon = widget.show == true ? visibleIcon : hiddenIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 15).h,
      decoration: BoxDecoration(
          color: Color(0xFF0F0F1E),
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(color: Color(0xFF6034A6), offset: Offset(5.w, 5.h)),
          ]
        ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              changeIcon(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10).w,
                child: VerticalDivider(
                  color: Color(0xFF6034A6),
                  indent: 25.h,
                  endIndent: 25.h,
                  thickness: 3.r,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.title}", style: TextStyle(color: Color(0xFF6034A6),fontSize: 22.sp, fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 200.w,
                    child: widget.show == true ? 
                      Text("${widget.content}", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis, maxLines: 3,)
                      :Text("${"*"*widget.content.length}", style: TextStyle(color: Color(0xFF6034A6), fontSize: 18.sp, fontWeight: FontWeight.bold)),
                    ),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () {
              setState(() {
                widget.show = !widget.show;
                activeIcon = widget.show == true ? visibleIcon : hiddenIcon;
              });
            },
            child: activeIcon
          ),
        ],
      ) 
    );
  }
}