import 'package:flutter/material.dart';
import 'package:golocal/components/events/eventCard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Eventlists extends StatefulWidget {
  const Eventlists({super.key});

  @override
  State<Eventlists> createState() => _EventlistsState();
}

class _EventlistsState extends State<Eventlists> {
  final SupabaseClient supabase = Supabase.instance.client;
  String selectedEvent = "All";
  bool _isLoading = true;
  List<String> _events = [];

  void _onEventSelected(String event) {
    setState(() {
      selectedEvent = event;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchClient();
  }

  Future<void> _fetchClient() async {
    try {
      final response = await supabase
          .from("Events")
          .select("event_type")
          .order("event_type");

      final events = (response as List)
          .map((row) => row['event_type']?.toString() ?? 'Unknown')
          .where((event) => event.isNotEmpty)
          .toSet()
          .toList();

      events.insert(0, 'All');

      setState(() {
        _events = events;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching client: $e");
      setState(() {
        _isLoading = false;
        _events = ['All'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        SizedBox(
          height: 50,
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : ListView.builder(
                  itemCount: _events.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final eventName = _events[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () => _onEventSelected(eventName),
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedEvent == eventName
                                ? Colors.black
                                : Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: const Color.fromARGB(255, 222, 222, 222),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: Text(
                              eventName,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: selectedEvent == eventName
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
        // Pass the scroll direction to Eventcard to make it horizontal
        SizedBox(
          // Added a SizedBox to limit the height of the horizontal list
          height: 350,
          child: Eventcard(
            selectedCity: selectedEvent,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}
