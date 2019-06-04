import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meals_catalogue/adapters/recipe_adapter.dart';

import 'package:meals_catalogue/models/recipe.dart';
import 'package:meals_catalogue/widgets/title_label.dart';

class MealsDetail extends StatefulWidget {
  final String idMeal;

  MealsDetail({this.idMeal});

  @override
  _MealsDetailState createState() => _MealsDetailState(idMeal: idMeal);
}

class _MealsDetailState extends State<MealsDetail> {
  final String idMeal;
  final apiUrl = "https://www.themealdb.com/api/json/v1/1/";
  var fitur = "";

  RecipeAdapter recipeAdapter;
  Recipe recipe;

  _MealsDetailState({this.idMeal});

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    var res = await http.get(apiUrl + "lookup.php?i=" + idMeal);
    final jsonRes = jsonDecode(res.body);

    recipeAdapter = RecipeAdapter.fromJson(jsonRes);
    if (recipeAdapter != null && recipeAdapter.recipe != null) {
      recipe = recipeAdapter.recipe[0];
    }

    //print(recipe.toJson());

    setState(() {});
  }

  bannerRecipe(img) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: recipe.idMeal.toString(),
            child: Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(img),
                    fit: BoxFit.cover,
                  )),
            ),
          )
        ],
      );

  bodyWidget(c) => Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              bannerRecipe(recipe.strMealThumb),
              TitleLabel(label: recipe.strMeal),
              Text(
                recipe.strTags != null ? recipe.strTags : "-",
                textAlign: TextAlign.center,
              ),
              TitleLabel(label: "Ingredients"),
              Column(mainAxisSize: MainAxisSize.max, children: [
                Card(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(recipe.strInstructions),
                ))
              ])
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Meals Detail"),
        ),
        body: recipe == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : bodyWidget(context));
  }
}
