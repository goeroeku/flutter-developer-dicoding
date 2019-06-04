import 'dart:convert';
import 'dart:async' show Future;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:meals_catalogue/model/meals.dart';
import 'package:meals_catalogue/page/meals_detail.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Meals Catalogue",
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Meals meals;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  Future<String> _loadAStudentAsset() async {
    return await rootBundle.loadString('assets/data/reseps.json');
  }

  Future fetchData() async {
    String jsonString = await _loadAStudentAsset();
    final jsonResponse = json.decode(jsonString);
    meals = Meals.fromJson(jsonResponse);
    // print(makanan.toJson());
    setState(() {});
  }

  bodyWidget(c) => GridView.count(
        crossAxisCount: 2,
        children: meals.reseps
            .map((row) => Padding(
                  padding: EdgeInsets.all(2.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => MealsDetail(
                                    reseps: row,
                                  )));
                    },
                    child: Card(
                      elevation: 3.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 120.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: ExactAssetImage(row.image),
                              fit: BoxFit.cover,
                            )),
                          ),
                          Text(
                            row.name,
                            style: TextStyle(fontSize: 16.0),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ))
            .toList(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Meals Catalogue"),
          elevation: 0.0,
        ),
        body: meals == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : bodyWidget(context));
  }
}
