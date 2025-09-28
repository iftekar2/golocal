// import 'package:flutter/material.dart';
// import 'package:golocal/components/destination/Destination.dart';
// import 'package:golocal/components/discoverTrips.dart';
// import 'package:golocal/components/events/viewEvent.dart';
// import 'package:golocal/components/favorites.dart';
// import 'package:golocal/components/searchPage.dart';
// import 'package:golocal/mainPage.dart';
// import 'package:golocal/supabase/destination/destination_supabase.dart';
// import 'package:golocal/supabase/event/event_supabase.dart';
// import 'package:golocal/components/discoverPlace/viewAllDiscoverPlaces.dart';
// import 'package:golocal/components/events/viewAllEvents.dart'; // Import the new page

// class BottomNavigation extends StatefulWidget {
//   static final GlobalKey<_BottomNavigationState> navigationKey =
//       GlobalKey<_BottomNavigationState>();

//   const BottomNavigation({super.key});

//   static void goToTab(int index) {
//     navigationKey.currentState?._navigateBottomBar(index);
//   }

//   static void navigateToDestination(DestinationSupabase destination) {
//     navigationKey.currentState?.showDestinationPage(destination);
//   }

//   static void navigateToEvent(EventSupabase event) {
//     navigationKey.currentState?.showEventPage(event);
//   }

//   static void navigateToAllDiscoverPlaces() {
//     navigationKey.currentState?.showAllDiscoverPlacesPage();
//   }

//   // NEW: Method to navigate to the "View All Events" page
//   static void navigateToAllEvents() {
//     navigationKey.currentState?.showAllEventsPage();
//   }

//   @override
//   State<BottomNavigation> createState() => _BottomNavigationState();
// }

// class _BottomNavigationState extends State<BottomNavigation> {
//   int _selectedIndex = 0;
//   DestinationSupabase? _currentDestination;
//   EventSupabase? _currentEvent;
//   bool _showAllDiscoverPlaces = false;

//   void _navigateBottomBar(int index) {
//     setState(() {
//       _selectedIndex = index;
//       _currentDestination = null;
//       _currentEvent = null;
//       _showAllDiscoverPlaces = false;
//     });
//   }

//   void showDestinationPage(DestinationSupabase destination) {
//     setState(() {
//       _selectedIndex = -1;
//       _currentDestination = destination;
//       _currentEvent = null;
//       _showAllDiscoverPlaces = false;
//     });
//   }

//   void showEventPage(EventSupabase event) {
//     setState(() {
//       _selectedIndex = -2;
//       _currentEvent = event;
//       _currentDestination = null;
//       _showAllDiscoverPlaces = false;
//     });
//   }

//   void showAllDiscoverPlacesPage() {
//     setState(() {
//       _selectedIndex = -3;
//       _currentDestination = null;
//       _currentEvent = null;
//     });
//   }

//   // NEW: Method to update the state to show the new page
//   void showAllEventsPage() {
//     setState(() {
//       _selectedIndex = -4; // Use a new unique index
//       _currentDestination = null;
//       _currentEvent = null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> pages = [
//       const Mainpage(),
//       const SearchPage(),
//       const Discovertrips(),
//       const Favorites(),
//     ];

//     Widget currentPage;
//     AppBar? currentAppBar;

//     if (_selectedIndex == -1 && _currentDestination != null) {
//       currentPage = Destination(destination: _currentDestination!);
//       currentAppBar = AppBar(
//         title: Text(_currentDestination!.locationName ?? 'Destination Details'),
//         backgroundColor: const Color.fromRGBO(248, 247, 243, 1),
//         forceMaterialTransparency: true,
//       );
//     } else if (_selectedIndex == -2 && _currentEvent != null) {
//       currentPage = Viewevent(event: _currentEvent!);
//     } else if (_selectedIndex == -3) {
//       currentPage = const Viewalldiscoverplaces();
//     } else if (_selectedIndex == -4) {
//       currentPage = const Viewallevents();
//     } else {
//       currentPage = pages[_selectedIndex];
//       currentAppBar = null;
//     }

//     return Scaffold(
//       appBar: currentAppBar,
//       body: currentPage,
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex >= 0 ? _selectedIndex : 0,
//         onTap: _navigateBottomBar,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home, size: 30),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search, size: 30),
//             label: "Search",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.explore, size: 30),
//             label: "Discover",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: "Favorite",
//           ),
//         ],
//         unselectedItemColor: Colors.grey,
//         selectedItemColor: Colors.black,
//         backgroundColor: const Color.fromRGBO(248, 247, 243, 1),
//         type: BottomNavigationBarType.fixed,
//         selectedFontSize: 14,
//         unselectedFontSize: 14,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:golocal/components/destination/Destination.dart';
import 'package:golocal/components/destination/viewAllPopularDestination.dart';
import 'package:golocal/components/discoverTrips.dart';
import 'package:golocal/components/events/viewEvent.dart';
import 'package:golocal/components/favorites.dart';
import 'package:golocal/components/searchPage.dart';
import 'package:golocal/mainPage.dart';
import 'package:golocal/supabase/destination/destination_supabase.dart';
import 'package:golocal/supabase/event/event_supabase.dart';
import 'package:golocal/components/discoverPlace/viewAllDiscoverPlaces.dart';
import 'package:golocal/components/events/viewAllEvents.dart';

class BottomNavigation extends StatefulWidget {
  static final GlobalKey<_BottomNavigationState> navigationKey =
      GlobalKey<_BottomNavigationState>();

  const BottomNavigation({super.key});

  static void goToTab(int index) {
    navigationKey.currentState?._navigateBottomBar(index);
  }

  static void navigateToDestination(DestinationSupabase destination) {
    navigationKey.currentState?.showDestinationPage(destination);
  }

  static void navigateToEvent(EventSupabase event) {
    navigationKey.currentState?.showEventPage(event);
  }

  static void navigateToAllDiscoverPlaces() {
    navigationKey.currentState?.showAllDiscoverPlacesPage();
  }

  static void navigateToAllEvents() {
    navigationKey.currentState?.showAllEventsPage();
  }

  // Add the new static method for "View All Popular Destinations"
  static void navigateToAllPopularDestinations() {
    navigationKey.currentState?.showAllPopularDestinationsPage();
  }

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  DestinationSupabase? _currentDestination;
  EventSupabase? _currentEvent;

  // No need for a separate boolean, the _selectedIndex handles it now

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
      _currentDestination = null;
      _currentEvent = null;
    });
  }

  void showDestinationPage(DestinationSupabase destination) {
    setState(() {
      _selectedIndex = -1;
      _currentDestination = destination;
      _currentEvent = null;
    });
  }

  void showEventPage(EventSupabase event) {
    setState(() {
      _selectedIndex = -2;
      _currentEvent = event;
      _currentDestination = null;
    });
  }

  void showAllDiscoverPlacesPage() {
    setState(() {
      _selectedIndex = -3;
      _currentDestination = null;
      _currentEvent = null;
    });
  }

  void showAllEventsPage() {
    setState(() {
      _selectedIndex = -4;
      _currentDestination = null;
      _currentEvent = null;
    });
  }

  // Add the new method to show the "View All Popular Destinations" page
  void showAllPopularDestinationsPage() {
    setState(() {
      _selectedIndex = -5; // Unique negative index
      _currentDestination = null;
      _currentEvent = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const Mainpage(),
      const SearchPage(),
      const Discovertrips(),
      const Favorites(),
    ];

    Widget currentPage;
    AppBar? currentAppBar;

    if (_selectedIndex == -1 && _currentDestination != null) {
      currentPage = Destination(destination: _currentDestination!);
      currentAppBar = AppBar(
        title: Text(_currentDestination!.locationName ?? 'Destination Details'),
        backgroundColor: const Color.fromRGBO(248, 247, 243, 1),
        forceMaterialTransparency: true,
      );
    } else if (_selectedIndex == -2 && _currentEvent != null) {
      currentPage = Viewevent(event: _currentEvent!);
      // currentAppBar = AppBar(
      //   title: Text(_currentEvent!.title ?? 'Event Details'),
      //   backgroundColor: const Color.fromRGBO(248, 247, 243, 1),
      //   forceMaterialTransparency: true,
      // );
    } else if (_selectedIndex == -3) {
      currentPage = const Viewalldiscoverplaces();
      currentAppBar = AppBar(
        title: const Text('All Discover Places'),
        backgroundColor: const Color.fromRGBO(248, 247, 243, 1),
      );
    } else if (_selectedIndex == -4) {
      currentPage = const Viewallevents();
      currentAppBar = AppBar(
        title: const Text('All Events'),
        backgroundColor: const Color.fromRGBO(248, 247, 243, 1),
      );
    }
    // Add the new condition for the "View All Popular Destinations" page
    else if (_selectedIndex == -5) {
      currentPage = const Viewallpopulardestination();
      // currentAppBar = AppBar(
      //   title: const Text('All Popular Destinations'),
      //   backgroundColor: const Color.fromRGBO(248, 247, 243, 1),
      // );
    } else {
      currentPage = pages[_selectedIndex];
      currentAppBar = null;
    }

    return Scaffold(
      appBar: currentAppBar,
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex >= 0 ? _selectedIndex : 0,
        onTap: _navigateBottomBar,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30),
            label: "Search",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.explore, size: 30),
          //   label: "Discover",
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
        ],
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        backgroundColor: const Color.fromRGBO(248, 247, 243, 1),
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14,
        unselectedFontSize: 14,
      ),
    );
  }
}
