import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:meals_catalogue/utils/api_helper.dart';

main() {
  group('getDessert', () {
    final mapJson = {
      'meals': [
        {
          "idMeal": "52893",
          "strMeal": "Apple & Blackberry Crumble",
          "strInstructions":
              "Heat oven to 180C/fan 160C/gas 4. Trim the fronds from the fennel and set aside. Cut the fennel bulbs in half, then cut each half into 3 wedges. Cook in boiling salted water for 10 mins, then drain well. Chop the fennel fronds roughly, then mix with the parsley and lemon zest.\r\n\r\nSpread the drained fennel over a shallow ovenproof dish, then add the tomatoes. Drizzle with olive oil, then bake for 10 mins. Nestle the salmon among the veg, sprinkle with lemon juice, then bake 15 mins more until the fish is just cooked. Scatter over the parsley and serve.",
          "strMealThumb":
              "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
          "strMealThumb":
              "https://www.themealdb.com/images/media/meals/1548772327.jpg",
          "strTags": "Paleo,Keto,HighFat,Baking,LowCarbs",
          "strCategory": "Seafood",
        },
      ]
    };
    test('menampilkan meals', () async {
      final ApiHelper apiHelper = ApiHelper();
      apiHelper.client = MockClient((request) async {
        return Response(json.encode(mapJson), 200);
      });

      final item = await apiHelper.fetchData();
      expect(item.meals.length, 1);
    });
    test('menampilkan recipe', () async {
      final ApiHelper apiHelper = ApiHelper();
      apiHelper.client = MockClient((request) async {
        return Response(json.encode(mapJson), 200);
      });

      final item = await apiHelper.fetchData();
      expect(item.meals[0].idMeal, "52893");
    });
  });
}
