import 'package:flutter/material.dart';

import 'package:meals_catalogue/model/recipe.dart';
import 'package:meals_catalogue/widgets/title_label.dart';

class MealsDetail extends StatelessWidget {
  final Recipe recipe;

  MealsDetail({this.recipe});

  bannerRecipe(img) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: recipe.id.toString(),
            child: Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: ExactAssetImage(img),
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
              bannerRecipe(recipe.image),
              TitleLabel(label: recipe.name),
              Text(
                recipe.description,
                textAlign: TextAlign.center,
              ),
              TitleLabel(label: "Bahan-bahan"),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: recipe.ingredients
                    .map((v) => Card(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(v),
                        )))
                    .toList(),
              )
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
        body: bodyWidget(context));
  }
}
