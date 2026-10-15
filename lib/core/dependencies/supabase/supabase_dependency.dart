import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDependency {
  static Future<void> initSupabaseDependency() async {
    await Supabase.initialize(
      url: 'https://gxsdqqrhmhsuuirspnsv.supabase.co',
      publishableKey: 'sb_publishable_45hxPO0TYx9orKlpe_gHtg_acGiAIPN',
    );
  }
}
