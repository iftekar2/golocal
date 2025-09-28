import 'package:flutter/material.dart';
import 'package:golocal/components/bottomNavigation.dart';
import 'package:golocal/supabase/destination/destination_supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LikeState {
  final Map<int, bool> _likedDestinations = {};

  bool isLiked(int? destinationId) => destinationId != null
      ? _likedDestinations[destinationId] ?? false
      : false;

  void toggleLike(int? destinationId) {
    if (destinationId != null) {
      _likedDestinations[destinationId] = !isLiked(destinationId);
    }
  }
}

class PopularDestination extends StatefulWidget {
  const PopularDestination({super.key});

  @override
  State<PopularDestination> createState() => _PopularDestinationState();
}

class _PopularDestinationState extends State<PopularDestination> {
  final LikeState _likeState = LikeState();
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<DestinationSupabase>> _fetchPopularDestinations() async {
    try {
      final response = await supabase
          .from('Destinations')
          .select()
          .gte('rating', 4.5)
          .order('rating', ascending: false)
          .limit(10);

      final destinations = (response as List)
          .map(
            (item) => DestinationSupabase.fromMap(item as Map<String, dynamic>),
          )
          .toList();

      return destinations;
    } catch (e) {
      print('Error fetching popular destinations: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<List<DestinationSupabase>>(
          future: _fetchPopularDestinations(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No destinations found."));
            } else {
              final destinations = snapshot.data!;
              return SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: destinations.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final destination = destinations[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 50),
                      child: GestureDetector(
                        onTap: () {
                          // Call the static method to change the main scaffold's body
                          BottomNavigation.navigateToDestination(destination);
                        },

                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: SizedBox(
                            width: 350,
                            height: 400,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Image.network(
                                      destination.imageUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey,
                                              child: const Center(
                                                child: Icon(
                                                  Icons.error,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            );
                                          },
                                    ),
                                  ),

                                  Positioned(
                                    top: 15,
                                    left: 15,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: const Color.fromRGBO(
                                            234,
                                            249,
                                            153,
                                            1,
                                          ),
                                          width: 1,
                                        ),
                                      ),

                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 20,
                                          ),

                                          const SizedBox(width: 4),
                                          Text(
                                            destination.rating!.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 15,
                                    right: 15,
                                    child: StatefulBuilder(
                                      builder: (context, setInnerState) {
                                        return GestureDetector(
                                          onTap: () {
                                            setInnerState(() {
                                              _likeState.toggleLike(
                                                destination.id,
                                              );
                                            });
                                          },

                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 8,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(
                                                0.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: const Color.fromRGBO(
                                                  234,
                                                  249,
                                                  153,
                                                  1,
                                                ),
                                                width: 1,
                                              ),
                                            ),

                                            child: Row(
                                              children: [
                                                Icon(
                                                  _likeState.isLiked(
                                                        destination.id,
                                                      )
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: Colors.amber,
                                                  size: 22,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 16,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(20),
                                      ),

                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            destination.locationName!,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),

                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on,
                                                color: Colors.white,
                                                size: 20,
                                              ),

                                              const SizedBox(width: 5),
                                              Text(
                                                "${destination.city!}, ${destination.country!}",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
