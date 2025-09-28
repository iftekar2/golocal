import 'package:flutter/material.dart';
import 'package:golocal/components/discoverPlace/discoverPlacesCard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DiscoverPlacesList extends StatefulWidget {
  final String selectedCity;
  const DiscoverPlacesList({super.key, required this.selectedCity});

  @override
  State<DiscoverPlacesList> createState() => _DiscoverPlacesListState();
}

class _DiscoverPlacesListState extends State<DiscoverPlacesList> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _destinations = [];
  final SupabaseClient supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _fetchDestinations();
  }

  @override
  void didUpdateWidget(covariant DiscoverPlacesList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedCity != widget.selectedCity) {
      _fetchDestinations();
    }
  }

  Future<void> _fetchDestinations() async {
    setState(() {
      _isLoading = true;
    });

    try {
      late final List response;

      if (widget.selectedCity == 'All') {
        response = await supabase
            .from('Destinations')
            .select()
            .order('created_at', ascending: false);
      } else {
        response = await supabase
            .from('Destinations')
            .select()
            .eq('city', widget.selectedCity)
            .order('created_at', ascending: false);
      }

      setState(() {
        _destinations = response.cast<Map<String, dynamic>>();
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching destinations: $e');
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

    if (_destinations.isEmpty) {
      return const Center(child: Text("No destinations found."));
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _destinations.length,
          itemBuilder: (context, index) {
            final destination = _destinations[index];
            return Discoverplacescard(destination: destination);
          },
        ),
      ),
    );
  }
}
