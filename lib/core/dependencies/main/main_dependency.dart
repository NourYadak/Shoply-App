import 'package:flutter/material.dart';
import 'package:shoply_app/core/dependencies/easy_localization/easy_localization_dependency.dart';
import 'package:shoply_app/core/dependencies/firebase/firebase_dependency.dart';
import 'package:shoply_app/core/dependencies/local_storage/local_storage_dependency.dart';
import 'package:shoply_app/core/dependencies/supabase/supabase_dependency.dart';

class MainDependency {
  static Future<void> mainInitDependency() async {
    WidgetsFlutterBinding.ensureInitialized();
    await LocalStorageDependency.initlocalStorageDependency();
    await FirebaseDependency.iniFirebaseDependency();
    await SupabaseDependency.initSupabaseDependency();
    await EasyLocalizationDependency.inttEasyLocalizationDependency();
  }
}
