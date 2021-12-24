import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:second_flutter_app/app_color.dart' as AppColors;
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  List? popularBooks;
  ScrollController? _scrollController;
  TabController? _tapController;
   // ignore: non_constant_identifier_names
   ReadData() async {
     await DefaultAssetBundle.of(context).loadString("json/popularBooks.json").then((s){
      setState(() {
        popularBooks = json.decode(s);
      });
    });
  }


  @override
  void initState(){
    super.initState();
    _tapController = TabController(length: 3, vsync: this);
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ImageIcon(AssetImage("img/menu.png"),size: 24,color: Colors.black,),
                  Row(
                    children: const [
                      Icon(Icons.search,size: 24,),
                      SizedBox(width: 10,),
                      Icon(Icons.notifications,size: 24,),
                    ],
                  )
                ],
              )
              ),
              const SizedBox(height: 20,),
              Row(
                children:[
                Container(
                  margin: const EdgeInsets.only(left:20),
                  child: const Text("Popular Books",style: TextStyle(fontSize: 30),)
                )
                ]
              ),
              const SizedBox(height:20),
              SizedBox(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      top:0,
                      left: -20,
                      right: 0,
                      child: SizedBox(
                height: 180,
                child: PageView.builder(
                    controller: PageController(viewportFraction: 0.8),
                    // ignore: unnecessary_null_comparison
                    // itemCount: 5,
                    itemCount: popularBooks==null?0:popularBooks!.length,
                    itemBuilder: ( _ , i){
                  return Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(right:10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(popularBooks![i]["img"]),
                          // "img/pic-6.png"
                          // popularBooks![i]["img"]
                        fit: BoxFit.fill
                      )
                    ),
                  );
                })
              )

                      ),

                  ],
                )
              ),
              Expanded(child: NestedScrollView(

              ))
            ],
          ),
        ),
      ),
    );
  }
}
