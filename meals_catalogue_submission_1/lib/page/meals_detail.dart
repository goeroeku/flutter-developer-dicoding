import 'package:flutter/material.dart';

import 'package:meals_catalogue/model/meals.dart';
import 'package:meals_catalogue/widgets/title_label.dart';

class MealsDetail extends StatelessWidget {
  final Reseps reseps;

  MealsDetail({this.reseps});

  bodyWidget(c) => Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 200.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: ExactAssetImage(reseps.image),
                          fit: BoxFit.cover,
                        )),
                  ),
                ],
              ),
              TitleLabel(label: reseps.name),
              Text(
                reseps.description,
                textAlign: TextAlign.center,
              ),
              TitleLabel(label: "Bahan-bahan"),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: reseps.ingredients
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
