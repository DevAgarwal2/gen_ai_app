import "package:flutter/material.dart";
class submitButton extends StatelessWidget {
  Function()? ontap;
   submitButton({
    super.key,
    required this.ontap
  });

  @override
  Widget build(BuildContext context) {

    return Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Colors.white),
        height: 50,
        width: 60,
        child: Center(
            child:
                IconButton(onPressed: ontap, icon: Icon(Icons.send))));
  }
}
