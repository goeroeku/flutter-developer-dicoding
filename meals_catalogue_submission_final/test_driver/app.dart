import 'package:flutter_driver/driver_extension.dart';
import 'package:meals_catalogue/main.dart' as free;
import 'package:meals_catalogue/main_paid.dart' as paid;

void main() {
  // This line enables the extension
  enableFlutterDriverExtension();

  // Call the `main()` function of your app or call `runApp` with any widget you
  // are interested in testing.
  free.main();
  paid.main();
}
