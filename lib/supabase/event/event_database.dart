import 'package:golocal/supabase/event/event_supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EventDatabase {
  final database = Supabase.instance.client.from("Events");

  /// Returns a stream of Events from the database.
  final stream = Supabase.instance.client
      .from('Events')
      .stream(primaryKey: ['id'])
      .map(
        (data) =>
            data.map((dataMap) => EventSupabase.fromMap(dataMap)).toList(),
      );
}
