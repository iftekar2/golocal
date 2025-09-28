import 'package:flutter/material.dart';
import 'package:golocal/components/events/eventCard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Viewallevents extends StatefulWidget {
  const Viewallevents({super.key});

  @override
  State<Viewallevents> createState() => _ViewalleventsState();
}

class _ViewalleventsState extends State<Viewallevents> {
  final SupabaseClient supabaseClient = Supabase.instance.client;
  bool _isLoading = true;
  List<Map<String, dynamic>> _allEvents = [];

  @override
  void initState() {
    super.initState();
    _fetchAllEvents();
  }

  Future<void> _fetchAllEvents() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await supabaseClient
          .from("Events")
          .select()
          .order('created_at', ascending: false);

      setState(() {
        _allEvents = response.cast<Map<String, dynamic>>();
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching All events: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This widget should not have its own Scaffold or AppBar.
    // It should be a standalone widget that is placed inside the
    // Scaffold of the BottomNavigation widget.

    // We can assume the page has been wrapped in a Scaffold by a parent widget.
    // Here, we can just return the main content directly.
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      // This will use the default vertical scroll
      child: ListView(children: [Eventcard(selectedCity: 'All')]),
    );
  }
}
