import 'package:flutter/material.dart';
import 'package:shoply_app/features/app/view/shoply_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shoply_app/core/local/local_storage.dart';
import 'package:shoply_app/features/app/view/shoply_app.dart';
import 'package:shoply_app/firebase_options.dart';

void main() async {
  await LocalStorage.instance.initSharedPreferences();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ShoplyApp());
}
