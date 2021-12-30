import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:second_flutter_app/app_color.dart' as AppColors;
import 'package:second_flutter_app/detail_audio_page.dart';
import 'package:second_flutter_app/my_tabs.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  List? popularBooks;
  List? books;
  ScrollController? _scrollController;
  TabController? _tabController;
   // ignore: non_constant_identifier_names
   ReadData() async {
     await DefaultAssetBundle.of(context).loadString("json/popularBooks.json").then((s){
      setState(() {
        popularBooks = json.decode(s);
      });
    });
     await DefaultAssetBundle.of(context).loadString("json/books.json").then((s){
       setState(() {
         books = json.decode(s);
       });
     });
  }


  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
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
                controller: _scrollController,
                headerSliverBuilder: (BuildContext context, bool isScrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: AppColors.sliverBackground,
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(50),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20,left: 10),
                          child: TabBar(
                            indicatorPadding: const EdgeInsets.all(0),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding: const EdgeInsets.only(right:10),
                            controller: _tabController,
                            isScrollable: true,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 7,
                                  offset: const Offset(0,0),
                                )
                              ]
                            ),
                            tabs: const [
                              AppTabs(color: AppColors.menu1Color, text:"New"),
                              AppTabs(color: AppColors.menu2Color, text:"Popular"),
                              AppTabs(color: AppColors.menu3Color, text:"Tranding")
                            ],
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                        itemCount: books==null?0:books!.length,
                        itemBuilder: (_,i){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>DetailAudioPage(booksData:books,index:i)));
                        },
                        child:Container(
                        margin: const EdgeInsets.only(left:20,right: 20,top: 10,bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.tabVarViewColor,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                offset: const Offset(0,0),
                                color: Colors.grey.withOpacity(0.2)
                              )
                            ]
                          ),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                width: 90,
                                height: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage(books![i]["img"])
                                    ),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.star, size: 24, color: AppColors.starColor,),
                                      const SizedBox(width:5),
                                      Text(books![i]["rating"], style: const TextStyle(color: AppColors.menu2Color),)
                                    ],
                                  ),
                                  Text(
                                    books![i]["title"],style: const TextStyle(fontSize: 16,fontFamily: "Avenir",fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    books![i]["text"],style: const TextStyle(fontSize: 16,fontFamily: "Avenir", color: AppColors.subTitleText),
                                  ),
                                  Container(
                                    width: 60,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: AppColors.loveColor
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text("Love", style: TextStyle(fontSize: 10,color: Colors.white),),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        ),
                      )
                      );
                    }),
                    const Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text("Content"),
                      ),
                    ),
                    const Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text("Content"),
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
