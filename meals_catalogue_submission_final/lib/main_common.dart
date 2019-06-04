import 'package:flutter/material.dart';
import 'package:meals_catalogue/adapters/meals_adapter.dart';
import 'package:meals_catalogue/app_config.dart';
import 'package:meals_catalogue/page/meals_detail.dart';
import 'package:meals_catalogue/utils/api_helper.dart';

void mainCommon() {
  // Here would be background init code, if any
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MealsAdapter mealsAdapter;
  int _currentUpperNav = 0;
  int _currentBottomNav = 0;

  // search
  TextEditingController _searchQuery;
  bool _isSearching = false;
  String searchQuery = "";

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQuery.clear();
      updateSearchQuery("");
    });
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: updateSearchQuery,
    );
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });

    fetchData();
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (_searchQuery == null || _searchQuery.text.isEmpty) {
              _stopSearching();
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }
  // end search

  @override
  void initState() {
    super.initState();

    _searchQuery = TextEditingController();

    fetchData();
  }

  fetchData() async {
    ApiHelper apiHelper = ApiHelper();

    mealsAdapter = await apiHelper.fetchData(
        currentBottomNav: _currentBottomNav,
        currentUpperNav: _currentUpperNav,
        isSearching: _isSearching,
        searchQuery: searchQuery);
    // print(mealsAdapter.toJson());

    setState(() {
      mealsAdapter = mealsAdapter;
    });
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

  mealsWidget() => mealsAdapter != null && mealsAdapter.meals != null
      ? Builder(
          builder: (context) => GridView.count(
                crossAxisCount: 2,
                children: mealsContent(context, mealsAdapter),
              ))
      : Center(
          child: CircularProgressIndicator(),
        );

  mealsContent(BuildContext context, MealsAdapter mealsAdapter) =>
      mealsAdapter.meals
          .map((row) => Padding(
                padding: EdgeInsets.all(2.0),
                child: InkWell(
                  onTap: () {
                    showSnackBar(context, row);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => MealsDetail(
                                  idMeal: row.idMeal,
                                )));
                  },
                  child: mealsCard(row),
                ),
              ))
          .toList();

  bodyWidget() => _currentBottomNav < 2
      ? mealsWidget()
      : TabBarView(
          children: [
            mealsWidget(),
            mealsWidget(),
          ],
        );

  void showSnackBar(context, item) {
    final snackBar = SnackBar(
      content: Text(item.strMeal),
      duration: Duration(seconds: 2),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  upperNav() => TabBar(
        onTap: onUpperNavTapped,
        tabs: [
          Tab(
            icon: Icon(Icons.timer_off),
            text: "Fav. Dessert",
          ),
          Tab(
            icon: Icon(Icons.add_alert),
            text: "Fav. Seafood",
          )
        ],
      );

  bottomNav() => BottomNavigationBar(
        onTap: onBottomNavTapped,
        currentIndex: _currentBottomNav,
        items: [
          BottomNavigationBarItem(
              title: Text("Dessert"), icon: Icon(Icons.timer_off)),
          BottomNavigationBarItem(
              title: Text("Seafood"), icon: Icon(Icons.add_alert)),
          BottomNavigationBarItem(
              title: Text("Favorite"), icon: Icon(Icons.favorite))
        ],
      );

  void onUpperNavTapped(int index) {
    setState(() {
      _currentUpperNav = index;
    });

    fetchData();
  }

  void onBottomNavTapped(int index) {
    setState(() {
      _currentBottomNav = index;
    });

    fetchData();
  }

  defaultController(String title) => DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: _isSearching ? _buildSearchField() : Text(title),
            actions: _buildActions(),
            bottom: _currentBottomNav > 1 ? upperNav() : null,
          ),
          body: bodyWidget(),
          bottomNavigationBar: bottomNav()));

  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: config.appDisplayName,
      home: defaultController(config.appDisplayName),
    );
  }
}
