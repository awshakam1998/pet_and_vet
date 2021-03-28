import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_and_vet/models/products.dart';
import 'package:pet_and_vet/models/user.dart';
import 'package:pet_and_vet/view/screens/consulting_screen.dart';
import 'package:pet_and_vet/view/widgets/type_card.dart';

class HomeTabView extends StatefulWidget {
  final String tabType;
  final UserApp user;

  const HomeTabView({Key key, this.tabType, this.user}) : super(key: key);

  @override
  _HomeTabViewState createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
    final databaseReference = FirebaseDatabase.instance.reference();
  int bottomIndex = 0;
  int topIndex = 0;
  List<String> catTabName = ['cats', 'food', 'equipment', 'consulting'];
  List<String> dogTabName = ['dogs', 'fooddogs', 'eq_dogs', 'consultingdog'];
  List<String> birdTabName = [
    'birds',
    'foodbirds',
    'eq_birds',
    'consultingbird'
  ];
  List<String> topList = ['cats', 'food', 'equipment', 'consulting'];
  List<String> imageListType = [
    'assets/images/cat.png',
    'assets/images/dog.png',
    'assets/images/birds.png',
  ];

  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _getView();
  }

  _getView() {
    switch (widget.tabType) {
      case 'cat':
        setState(() {
          bottomIndex = 0;
          topList = catTabName;
        });
        break;
      case 'dog':
        setState(() {
          bottomIndex = 1;
          topList = dogTabName;
        });
        break;
      case 'bird':
        setState(() {
          bottomIndex = 2;
          topList = birdTabName;
        });
        break;
    }
    getProductsList();
  }

  getProductsList() async {
    databaseReference.child('4').child('data').once().then((value) {
      List<dynamic> snapshot = value.value;
      snapshot.forEach((map) {
        Map<String, dynamic> json = Map.from(map);
       if(mounted)
         setState(() {
           products.add(Product.fromJson(json));
         });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
        body: products.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      scrollDirection: Axis.vertical,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              topIndex = 0;
                            });
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  imageListType[bottomIndex],
                                ),
                              ),
                            ),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                'types'.tr,
                                style: TextStyle(
                                  decoration: topIndex == 0
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                ),
                              ),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              topIndex = 1;
                            });
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  imageListType[bottomIndex],
                                ),
                              ),
                            ),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                'foods'.tr,
                                style: TextStyle(
                                  decoration: topIndex == 1
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                ),
                              ),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              topIndex = 2;
                            });
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  imageListType[bottomIndex],
                                ),
                              ),
                            ),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                'equipments'.tr,
                                style: TextStyle(
                                  decoration: topIndex == 2
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                ),
                              ),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              topIndex = 3;
                            });
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  imageListType[bottomIndex],
                                ),
                              ),
                            ),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                'consulting'.tr,
                                style: TextStyle(
                                  decoration: topIndex == 3
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                ),
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: topIndex == 3
                        ? ConsultingScreen(type: topList[topIndex],section: widget.tabType,user: widget.user,)
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: products
                                .where((element) =>
                                    element.category == topList[topIndex])
                                .length,
                            itemBuilder: (context, index) => TypeCard(
                              product: products
                                  .where((element) =>
                                      element.category == topList[topIndex])
                                  .elementAt(index),
                            ),
                          ),
                  )
                ],
              ));
  }
}
