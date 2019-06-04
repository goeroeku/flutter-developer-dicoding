import 'package:flutter/material.dart';
import 'package:meals_catalogue/app_config.dart';
import 'package:meals_catalogue/main_common.dart';

void main() {
  var configuredApp = AppConfig(
    appDisplayName: "Meals Catalogue - Pro",
    appInternalId: 2,
    child: Home(),
  );

  mainCommon();

  runApp(configuredApp);
}