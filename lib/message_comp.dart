import "package:flutter/material.dart";
import "package:flutter_markdown/flutter_markdown.dart";

class MessageComp extends StatelessWidget {
  String text;
  bool isAi;
  MessageComp({super.key, required this.text, required this.isAi});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          !isAi ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
                Divider(color: Colors.grey.shade800,height: 5,),

        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 7,bottom: 7),
                child: MarkdownBody(
                  data: text,
                  selectable: true,
                ),
              ),
              
            ),
            
          ),
        ),
      ],
    );
  }
}
