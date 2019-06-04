import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Show Homepage', () {
    final navButtonTabDessert = find.text('Dessert');
    final mealsNameOne = find.text("Apple & Blackberry Crumble");
    final mealsNameTwo = find.text("Apple Frangipan Tart");
    final navButtonTabFavorite = find.text('Favorite');
    final favoriteButton = find.byTooltip('Favorite');
    final tabFavoriteDessert = find.text('Fav. Dessert');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Show Dessert nav button', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      expect(await driver.getText(navButtonTabDessert), "Dessert");
    });

    test('Show Meals : Apple & Blackberry Crumble', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      expect(await driver.getText(mealsNameOne), "Apple & Blackberry Crumble");
    });

    test('Show Recipe', () async {
      // First, tap on the button
      await driver.tap(mealsNameOne);

      // Then, verify the counter text has been incremented by 1
      expect(await driver.getText(mealsNameOne), "Apple & Blackberry Crumble");
    });

    test('Show Favorite button', () async {
      // First, tap on the button
      await driver.tap(favoriteButton);

      // Then, verify the counter text has been incremented by 1
      expect(await driver.getText(mealsNameOne), "Apple & Blackberry Crumble");
    });

    test('Back to home', () async {
      // First, tap on the button
      await driver.tap(find.byTooltip('Back'));

      // Then, verify the counter text has been incremented by 1
      expect(await driver.getText(mealsNameTwo), "Apple Frangipan Tart");
    });

    test('Show Favorite nav button', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      expect(await driver.getText(navButtonTabFavorite), "Favorite");
    });

    test('Show Favorite', () async {
      // First, tap on the button
      await driver.tap(navButtonTabFavorite);

      // Then, verify the counter text has been incremented by 1
      expect(await driver.getText(tabFavoriteDessert), "Fav. Dessert");
    });
  });
}
