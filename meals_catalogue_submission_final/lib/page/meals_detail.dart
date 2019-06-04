import 'package:flutter/material.dart';
import 'package:meals_catalogue/models/favorite.dart';
import 'package:meals_catalogue/models/recipe.dart';
import 'package:meals_catalogue/utils/api_helper.dart';
import 'package:meals_catalogue/utils/db_helper.dart';
import 'package:meals_catalogue/widgets/title_label.dart';

class MealsDetail extends StatefulWidget {
  final String idMeal;
  final String category;

  MealsDetail({this.idMeal, this.category});

  @override
  _MealsDetailState createState() =>
      _MealsDetailState(idMeal: idMeal, category: category);
}

class _MealsDetailState extends State<MealsDetail> {
  final String idMeal;
  final String category;
  var isFavorite = false;

  Recipe recipe;

  _MealsDetailState({this.idMeal, this.category});

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    ApiHelper apiHelper = ApiHelper();

    Favorite favorite = await apiHelper.fetchDetail(idMeal: idMeal);

    setState(() {
      recipe = favorite.recipe;
      isFavorite = favorite.isFavorite;
    });
  }

  setFavorite() async {
    var db = DBHelper();

    Recipe favorite = Recipe(
        idMeal: recipe.idMeal,
        strMeal: recipe.strMeal,
        strInstructions: recipe.strInstructions,
        strMealThumb: recipe.strMealThumb,
        strTags: recipe.strTags,
        strCategory: recipe.strCategory);

    if (!isFavorite) {
      await db.insert(favorite);
    } else {
      await db.delete(favorite);
    }

    setState(() {
      isFavorite = !isFavorite;
    });
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
          actions: <Widget>[
            IconButton(
              icon: isFavorite
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border),
              onPressed: () {
                setFavorite();
              },
              tooltip: "Favorite",
            ),
          ],
        ),
        body: recipe == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : bodyWidget(context));
  }
}
