import 'package:golocal/supabase/destination/destination_supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DestinationDatabase {
  final database = Supabase.instance.client.from("Destinations");

  /// Returns a stream of destinations from the database.
  final stream = Supabase.instance.client
      .from('Destinations')
      .stream(primaryKey: ['id'])
      .map(
        (data) => data
            .map((dataMap) => DestinationSupabase.fromMap(dataMap))
            .toList(),
      );
}
