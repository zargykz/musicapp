// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/my_tabs.dart';
import 'app_colors.dart' as AppColors;
import 'detail_audio_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List popularSongs = [];
  List inicio = [];
  ScrollController? _scrollController;
  TabController? _tabController;
  // ignore: non_constant_identifier_names
  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/popular.json")
        .then((s) {
      setState(() {
        popularSongs = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString("json/inicio.json")
        .then((s) {
      setState(() {
        inicio = json.decode(s);
      });
    });
  }

  @override
  void initState() {
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
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ignore: prefer_const_constructors
                    Icon(Icons.menu, size: 30, color: Colors.black),
                    Row(
                      children: const [
                        Icon(Icons.search, size: 30, color: Colors.black),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.notifications, size: 30, color: Colors.black)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text("Best Music Online",
                          style: TextStyle(fontSize: 30))),
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 180,
                child: Stack(children: [
                  Positioned(
                      top: 0,
                      left: -20,
                      right: 0,
                      child: SizedBox(
                        height: 180,
                        child: BounceInDown(
                          child: PageView.builder(
                              controller: PageController(viewportFraction: 0.8),
                              itemCount:
                                  // ignore: unnecessary_null_comparison
                                  popularSongs == null
                                      ? 0
                                      : popularSongs.length,
                              itemBuilder: (_, i) {
                                return Container(
                                  height: 180,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              popularSongs[i]["img"]),
                                          fit: BoxFit.fill)),
                                );
                              }),
                        ),
                      )),
                ]),
              ),
              Expanded(
                  child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (BuildContext, bool isScroll) {
                  return [
                    SliverAppBar(
                        pinned: true,
                        backgroundColor: AppColors.sliverBackground,
                        bottom: PreferredSize(
                            preferredSize: Size.fromHeight(50),
                            child: ElasticIn(
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: TabBar(
                                    indicatorPadding: const EdgeInsets.all(0),
                                    indicatorSize: TabBarIndicatorSize.label,
                                    labelPadding:
                                        const EdgeInsets.only(left: 8),
                                    controller: _tabController,
                                    isScrollable: true,
                                    indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              blurRadius: 7,
                                              offset: Offset(0, 0))
                                        ]),
                                    tabs: [
                                      AppTabs(
                                          color: AppColors.menu1Color,
                                          text: "Nuevas"),
                                      AppTabs(
                                          color: AppColors.menu2Color,
                                          text: "Favoritas"),
                                      AppTabs(
                                          color: AppColors.menu3Color,
                                          text: "Trending")
                                    ],
                                  ),
                                ),
                                duration: Duration(seconds: 3))))
                  ];
                },
                body: TabBarView(
                  //Aca se controlan las tab view
                  controller: _tabController,
                  children: [
                    ListView.builder(
                        itemCount: inicio == null ? 0 : inicio.length,
                        itemBuilder: (_, i) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailAudioPage(
                                            inicialData: inicio, index: i)));
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.tabVarViewColor,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 2,
                                            offset: Offset(0, 0),
                                            color: Colors.grey.withOpacity(0.2),
                                          )
                                        ]),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: SlideInRight(
                                        child: Row(
                                          children: [
                                            Container(
                                                width: 90,
                                                height: 120,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                          inicio[i]["img"],
                                                        ),
                                                        fit: BoxFit.fill))),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      size: 24,
                                                      color:
                                                          AppColors.starColor,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(inicio[i]["rating"],
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .menu2Color))
                                                  ],
                                                ),
                                                Text(inicio[i]["title"],
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: "Avenir",
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(inicio[i]["text"],
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontFamily: "Avenir",
                                                        color: AppColors
                                                            .subTitleText)),
                                                Container(
                                                  width: 60,
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                      color:
                                                          AppColors.loveColor),
                                                  child: Text("Love",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily: "Avenir",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.white70)),
                                                  alignment: Alignment.center,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        duration: Duration(seconds: 3),
                                      ),
                                    ),
                                  )));
                        }),
                    Material(
                        child: ListTile(
                            //Agregar algo aca

                            )),
                    Material(
                        child: ListTile(
                      leading: CircleAvatar(backgroundColor: Colors.grey),
                      title: Text("Content"),
                    ))
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
