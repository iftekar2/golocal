import 'package:flutter/material.dart';
import 'package:golocal/components/discoverPlace/discoverPlacesCard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Viewalldiscoverplaces extends StatefulWidget {
  const Viewalldiscoverplaces({super.key});

  @override
  State<Viewalldiscoverplaces> createState() => _ViewalldiscoverplacesState();
}

class _ViewalldiscoverplacesState extends State<Viewalldiscoverplaces> {
  final SupabaseClient supabaseClient = Supabase.instance.client;
  bool _isLoading = true;
  List<Map<String, dynamic>> _allDiscoverplaces = [];

  @override
  void initState() {
    super.initState();
    _fetchAllDiscoverPlaces();
  }

  Future<void> _fetchAllDiscoverPlaces() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await supabaseClient
          .from("Destinations")
          .select()
          .order("created_at", ascending: false);

      setState(() {
        _allDiscoverplaces = response.cast<Map<String, dynamic>>();
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching All Discover Places: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Discover Places"),
        backgroundColor: const Color.fromRGBO(248, 247, 243, 1),
        forceMaterialTransparency: true,
      ),
      backgroundColor: const Color.fromRGBO(248, 247, 243, 1),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _allDiscoverplaces.isEmpty
          ? const Center(child: Text("No Discover Places Available."))
          : ListView.builder(
              itemCount: _allDiscoverplaces.length,
              itemBuilder: (context, index) {
                final place = _allDiscoverplaces[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Discoverplacescard(destination: place),
                );
              },
            ),
    );
  }
}
