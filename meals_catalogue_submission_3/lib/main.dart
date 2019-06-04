import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:meals_catalogue/adapters/meals_adapter.dart';

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
  MealsAdapter mealsAdapter;
  int _currentTab = 0;
  final apiUrl = "https://www.themealdb.com/api/json/v1/1/";
  var fitur = "";

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    if (_currentTab == 0) {
      fitur = "filter.php?c=Dessert";
    } else {
      fitur = "filter.php?c=Seafood";
    }

    var res = await http.get(apiUrl + fitur);
    final jsonRes = jsonDecode(res.body);

    mealsAdapter = MealsAdapter.fromJson(jsonRes);

    setState(() {});
  }

  mealsCard(item) => Card(
        elevation: 3.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Hero(
              tag: item.idMeal.toString(),
              child: Container(
                height: 120.0,
                width: 100.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(item.strMealThumb),
                  fit: BoxFit.cover,
                )),
              ),
            ),
            Text(
              item.strMeal,
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );

  bodyWidget(c) => Builder(
      builder: (context) => GridView.count(
            crossAxisCount: 2,
            children: mealsAdapter.meals
                .map((row) => Padding(
                      padding: EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: () {
                          showSnackBar(context, row);

                          Navigator.push(
                              c,
                              MaterialPageRoute(
                                  builder: (c) => MealsDetail(
                                        idMeal: row.idMeal,
                                      )));
                        },
                        child: mealsCard(row),
                      ),
                    ))
                .toList(),
          ));

  void showSnackBar(context, item) {
    final snackBar = SnackBar(
      content: Text(item.strMeal),
      duration: Duration(seconds: 2),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  bottomNav() => BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentTab,
        items: [
          BottomNavigationBarItem(
              title: Text("Desert"), icon: Icon(Icons.timer_off)),
          BottomNavigationBarItem(
              title: Text("Seafood"), icon: Icon(Icons.add_alert))
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
        body: mealsAdapter == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : bodyWidget(context),
        bottomNavigationBar: bottomNav());
  }
}
