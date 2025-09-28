import 'package:flutter/material.dart';
import 'package:golocal/components/bottomNavigation.dart';
import 'package:golocal/components/discoverPlace/DiscoverPlacesList.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Discoverplaces extends StatefulWidget {
  const Discoverplaces({super.key});

  @override
  State<Discoverplaces> createState() => _DiscoverplacesState();
}

class _DiscoverplacesState extends State<Discoverplaces> {
  // Supabase client instance
  final SupabaseClient supabase = Supabase.instance.client;
  String selectedCity = "All";
  bool _isLoading = true;
  List<String> _cities = [];

  void _onCitySelected(String city) {
    setState(() {
      selectedCity = city;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchCities();
  }

  Future<void> _fetchCities() async {
    try {
      final response = await supabase
          .from('Destinations')
          .select('city')
          .order('city')
          .limit(5);

      final cities = (response as List)
          .map((row) => row['city'] as String)
          .toSet()
          .toList();

      cities.insert(0, 'All');

      setState(() {
        _cities = cities;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching cities: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Discover Places",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => Viewalldiscoverplaces(),
              //       ),
              //     );
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.only(right: 20),
              //     child: const Text(
              //       "View All",
              //       style: TextStyle(
              //         fontSize: 16,
              //         fontWeight: FontWeight.w500,
              //         color: Color.fromARGB(255, 118, 118, 118),
              //       ),
              //     ),
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  // Replace Navigator.push with this
                  BottomNavigation.navigateToAllDiscoverPlaces();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: const Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 118, 118, 118),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 50,
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : ListView.builder(
                    itemCount: _cities.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final cityName = _cities[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            _onCitySelected(cityName);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedCity == cityName
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
                                cityName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: selectedCity == cityName
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
          DiscoverPlacesList(selectedCity: selectedCity),
        ],
      ),
    );
  }
}
