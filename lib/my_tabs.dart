
import 'package:flutter/material.dart';

class AppTabs extends StatelessWidget {
  const AppTabs({Key? key, this.color, this.text}) : super(key: key);
  final Color? color;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return  Container(
      width:120,
      height: 50,
      child: Text(
        text! ,style: const TextStyle(color: Colors.white,fontSize: 20),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 7,
              offset: Offset(0,0),
            )
          ]
      ),
    );
  }
}
