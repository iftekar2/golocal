import 'package:flutter/material.dart';
import 'package:golocal/components/destination/DestinationCardItem.dart';
import 'package:golocal/supabase/destination/destination_supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Viewallpopulardestination extends StatefulWidget {
  const Viewallpopulardestination({super.key});

  @override
  State<Viewallpopulardestination> createState() =>
      _ViewallpopulardestinationState();
}

class _ViewallpopulardestinationState extends State<Viewallpopulardestination> {
  final SupabaseClient supabaseClient = Supabase.instance.client;
  bool _isLoading = true;
  List<DestinationSupabase> _allPopularDestinations = [];

  @override
  void initState() {
    super.initState();
    _fetchAllPopularDestinations();
  }

  Future<void> _fetchAllPopularDestinations() async {
    try {
      final response = await supabaseClient
          .from("Destinations")
          .select()
          .gte('rating', 4.5)
          .order('rating', ascending: false);

      final destinations = (response as List)
          .map(
            (item) => DestinationSupabase.fromMap(item as Map<String, dynamic>),
          )
          .toList();

      setState(() {
        _allPopularDestinations = destinations;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching All Popular Destination: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Popular Destinations'),
        backgroundColor: const Color.fromRGBO(248, 247, 243, 1),
      ),
      backgroundColor: const Color.fromRGBO(248, 247, 243, 1),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _allPopularDestinations.isEmpty
          ? const Center(child: Text("No Popular Destinations Available."))
          : ListView.builder(
              itemCount: _allPopularDestinations.length,
              itemBuilder: (context, index) {
                final place = _allPopularDestinations[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: DestinationCardItem(destination: place),
                );
              },
            ),
    );
  }
}
