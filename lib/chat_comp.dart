import "package:flutter/material.dart";

class ChatComp extends StatelessWidget {
  final String text;
  final Icon icon;
  final Function()? onPressed;
  final TextEditingController textEditingController;
  const ChatComp(
      {super.key,
      required this.text,
      required this.icon,
      required this.textEditingController,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12)
      ),
      height: 55,
      width: 280,
      child: Row(
        
        children: [
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 10),
              child: TextField(
                controller: textEditingController,
                
                decoration: InputDecoration(hintText: text,border: InputBorder.none),
                
              ),
            ),
          ),
          IconButton(onPressed: onPressed, icon: icon)
        ],
      ),
      
    );
  }
}
