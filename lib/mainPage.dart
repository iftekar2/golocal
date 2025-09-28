import 'package:flutter/material.dart';
import 'package:golocal/components/bottomNavigation.dart';
import 'package:golocal/components/destination/popularDestinationWidget.dart';
import 'package:golocal/components/discoverPlace/discoverPlaces.dart';
import 'package:golocal/components/events/event.dart';

class Mainpage extends StatelessWidget {
  const Mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(248, 247, 243, 1),
        toolbarHeight: 20,
        forceMaterialTransparency: true,
      ),

      backgroundColor: const Color.fromRGBO(248, 247, 243, 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                readOnly: true,
                onTap: () {
                  BottomNavigation.goToTab(1);
                },
                decoration: InputDecoration(
                  hintText: 'Search destinations...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),

            const SizedBox(height: 30),
            Event(),
            const SizedBox(height: 20),
            Discoverplaces(),
            const SizedBox(height: 20),
            Populardestinationwidget(),
          ],
        ),
      ),
    );
  }
}
