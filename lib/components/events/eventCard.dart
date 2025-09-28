import 'package:flutter/material.dart';
import 'package:golocal/components/events/eventCardItem.dart';
import 'package:golocal/supabase/event/event_supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Eventcard extends StatefulWidget {
  final String selectedCity;
  // Add a new parameter for the scroll direction
  final Axis scrollDirection;

  // Make the new parameter required in the constructor
  const Eventcard({
    super.key,
    required this.selectedCity,
    this.scrollDirection = Axis.vertical,
  });

  @override
  State<Eventcard> createState() => _EventcardState();
}

class _EventcardState extends State<Eventcard> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _events = [];
  final SupabaseClient supabaseClient = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  @override
  void didUpdateWidget(covariant Eventcard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedCity != widget.selectedCity) {
      _fetchEvents();
    }
  }

  Future<void> _fetchEvents() async {
    setState(() {
      _isLoading = true;
    });

    try {
      late final List response;

      if (widget.selectedCity == 'All') {
        response = await supabaseClient
            .from("Events")
            .select()
            .order('created_at', ascending: false);
      } else {
        response = await supabaseClient
            .from('Events')
            .select()
            .eq('event_type', widget.selectedCity)
            .order('created_at', ascending: false);
      }

      setState(() {
        _events = response.cast<Map<String, dynamic>>();
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching event: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_events.isEmpty) {
      return const Center(child: Text("No destinations found."));
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      // Use the new parameter to set the scroll direction
      child: ListView.builder(
        // Set the scroll direction dynamically
        scrollDirection: widget.scrollDirection,
        // Conditional properties based on direction
        shrinkWrap: widget.scrollDirection == Axis.vertical ? true : false,
        physics: widget.scrollDirection == Axis.vertical
            ? const NeverScrollableScrollPhysics()
            : null,

        itemCount: _events.length,
        itemBuilder: (context, index) {
          final event = _events[index];
          // Add padding for both vertical and horizontal spacing
          return Padding(
            padding: EdgeInsets.only(
              right: widget.scrollDirection == Axis.horizontal ? 10 : 0,
              bottom: widget.scrollDirection == Axis.vertical ? 15 : 0,
            ),
            child: Eventcarditem(event: EventSupabase.fromMap(event)),
          );
        },
      ),
    );
  }
}
