import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meals_catalogue/widgets/title_label.dart';

void main() {
  testWidgets('Load Homepage', (WidgetTester tester) async {
    final String label = "Ini Judul";

     await tester.pumpWidget(MaterialApp(
       title: "Meals Catalogue",
       home: Scaffold(
         appBar: AppBar(
           title: Text("Meals Catalogue"),
         ),
         body: TitleLabel(
           label: label,
         ),
       )));

         expect(find.text(label), findsOneWidget);
  });
}
