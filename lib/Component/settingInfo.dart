import 'package:flutter/material.dart';
class SettingInfo extends StatefulWidget {
  final String title;
  final String content;
  const SettingInfo({
    required this.title,
    required this.content,
    super.key
  });
  @override
  State<SettingInfo> createState() => _SettingInfoState();
}

class _SettingInfoState extends State<SettingInfo> {
  late TextEditingController contentController = new TextEditingController(text: widget.content);

  changeIcon(){
    if(widget.title == "Username"){
      return Icon(Icons.person, color: Color(0xFF6034A6), size: 40);
    }
    if(widget.title == "Email"){
      return Icon(Icons.email, color: Color(0xFF6034A6), size: 40);
    }
    if(widget.title == "Password"){
      return Icon(Icons.lock_person, color: Color(0xFF6034A6), size: 40);
    }
    else{
      return Icon(Icons.person, color: Color(0xFF6034A6), size: 40);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                changeIcon(),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text("${widget.title}", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
                ),
              ],
            ),
          ),
          TextFormField(
            controller: contentController,
              validator: (value) {
                if (value!.length < 3 || value == null){
                return "username can't be empty";
                }
                else{
                  return null; 
                }
              },
              cursorColor: Color(0xFF6034A6),
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
              decoration: InputDecoration(
                hintText: "${widget.title}",
                // prefixIcon: changeIcon(),
                hintStyle: TextStyle(color:Color(0xFFAEAEB3)),
                // enabled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Color(0xFF6034A6)),
                  borderRadius: BorderRadius.circular(35)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Color(0xFF6034A6)),
                  borderRadius: BorderRadius.circular(35)
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.red),
                  borderRadius: BorderRadius.circular(35)
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Color(0xFF6034A6)),
                  borderRadius: BorderRadius.circular(35)
                ), 
              ),
            ),
        ],
      ),
    );
  }
}