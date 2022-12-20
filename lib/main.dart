// @dart=2.9

import 'package:croco/src/services/connection.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  await dotenv.load(fileName: ".env");
  await Connection.loadSettings();

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(settingsController));
}
