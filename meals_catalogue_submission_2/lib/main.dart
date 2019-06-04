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
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  Future<String> _loadAStudentAsset() async {
    return await rootBundle.loadString('assets/data/recipe.json');
  }

  Future fetchData() async {
    String jsonString = await _loadAStudentAsset();
    final jsonResponse = json.decode(jsonString);

    if (_currentTab == 0) {
      meals = Meals.fromJson(jsonResponse);
      //print(meals.toJson());
    } else {
      int category = _currentTab - 1;
      meals = Meals.fromJsonCategory(jsonResponse, category);
      //print(meals.toJsonCategory(category));
    }

    setState(() {});
  }

  mealsCard(item) => Card(
        elevation: 3.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Hero(
              tag: item.id.toString(),
              child: Container(
                height: 120.0,
                width: 100.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: ExactAssetImage(item.image),
                  fit: BoxFit.cover,
                )),
              ),
            ),
            Text(
              item.name,
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );

  bodyWidget(c) => Builder(
      builder: (context) => GridView.count(
            crossAxisCount: 2,
            children: meals.recipe
                .map((row) => Padding(
                      padding: EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: () {
                          showSnackBar(context, row);

                          Navigator.push(
                              c,
                              MaterialPageRoute(
                                  builder: (c) => MealsDetail(
                                        recipe: row,
                                      )));
                        },
                        child: mealsCard(row),
                      ),
                    ))
                .toList(),
          ));

  void showSnackBar(context, item) {
    final snackBar = SnackBar(
      content: Text(item.name),
      duration: Duration(seconds: 2),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  bottomNav() => BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentTab,
        items: [
          BottomNavigationBarItem(
              title: Text("All"), icon: Icon(Icons.timer_off)),
          BottomNavigationBarItem(
              title: Text("Breakfast"), icon: Icon(Icons.add_alert)),
          BottomNavigationBarItem(
              title: Text("Desert"), icon: Icon(Icons.access_alarm))
        ],
      );

  void onTabTapped(int index) {
    setState(() {
      _currentTab = index;
    });

    fetchData();
  }

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
            : bodyWidget(context),
        bottomNavigationBar: bottomNav());
  }
}
