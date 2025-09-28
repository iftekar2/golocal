import 'package:flutter/material.dart';
import 'package:golocal/components/destination/popular-destination.dart';
import 'package:golocal/components/bottomNavigation.dart';

class Populardestinationwidget extends StatelessWidget {
  const Populardestinationwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Popular Destinations",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  // Call the new static method
                  BottomNavigation.navigateToAllPopularDestinations();
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
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
          const SizedBox(height: 10),
          const PopularDestination(),
        ],
      ),
    );
  }
}
