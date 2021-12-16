import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:second_flutter_app/app_color.dart' as AppColors;
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Row(
                children: const [
                  ImageIcon(AssetImage("img/menu.png"),size: 24,color: Colors.black,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
