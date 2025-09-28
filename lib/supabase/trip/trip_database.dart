import 'package:golocal/supabase/trip/trip_supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TripDatabase {
  final database = Supabase.instance.client.from("Trips");

  /// Returns a stream of Trips from the database.
  final stream = Supabase.instance.client
      .from('Trips')
      .stream(primaryKey: ['id'])
      .map(
        (data) => data.map((dataMap) => TripSupabase.fromMap(dataMap)).toList(),
      );
}
