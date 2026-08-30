import 'package:flutter/material.dart';
import 'package:beautipholl/app.dart';
import 'package:beautipholl/core/services/storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(const Beautipholl());
}
