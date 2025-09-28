import 'package:flutter/material.dart';
import 'package:golocal/components/bottomNavigation.dart';
import 'package:golocal/supabase/destination/destination_supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<DestinationSupabase> _searchResults = [];
  bool _isLoading = false;

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await Supabase.instance.client
          .from('Destinations')
          .select()
          .ilike('location_name', '%$query%')
          .order('location_name');

      setState(() {
        _searchResults = (response as List)
            .map((item) => DestinationSupabase.fromMap(item))
            .toList();
      });
    } catch (e) {
      print('Error performing search: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(248, 247, 243, 1),
        title: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search destinations...',
              border: InputBorder.none,
              hintStyle: TextStyle(fontSize: 20),
            ),
            style: TextStyle(fontSize: 20),
            onChanged: (value) => _performSearch(value),
          ),
        ),
      ),

      backgroundColor: const Color.fromRGBO(248, 247, 243, 1),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _searchResults.isEmpty
          ? Center(
              child: Text(
                _searchController.text.isEmpty
                    ? 'Start typing to search'
                    : 'No results found',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final destination = _searchResults[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        destination.imageUrl ?? '',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey,
                          child: const Icon(Icons.image),
                        ),
                      ),
                    ),
                    title: Text(destination.locationName ?? ''),
                    subtitle: Text(
                      '${destination.city}, ${destination.country}',
                    ),
                    onTap: () {
                      BottomNavigation.navigateToDestination(destination);
                    },
                  ),
                );
              },
            ),
    );
  }
}
