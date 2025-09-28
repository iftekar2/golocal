import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseConfig {
  static String get url {
    final url = dotenv.env['SUPABASE_URL'];
    return url ?? '';
  }

  static String get anonKey {
    final key = dotenv.env['SUPABASE_ANON_KEY'];
    return key ?? '';
  }
}
