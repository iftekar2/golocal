// import 'package:flutter/material.dart';
// import 'package:golocal/components/bottomNavigation.dart';
// import 'package:golocal/supabase/event/event_supabase.dart';

// class Eventcarditem extends StatefulWidget {
//   final Map<String, dynamic> event;

//   const Eventcarditem({super.key, required this.event});

//   @override
//   State<Eventcarditem> createState() => _EventcarditemState();
// }

// class _EventcarditemState extends State<Eventcarditem> {
//   // Each card now has its own isLiked state
//   bool _isLiked = false;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 10),
//       child: SizedBox(
//         width: 350,
//         child: GestureDetector(
//           onTap: () {
//             BottomNavigation.navigateToEvent(
//               EventSupabase.fromMap(widget.event),
//             );
//           },

//           child: Card(
//             color: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),

//             child: Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: Image.network(
//                     widget.event['event_image'] ??
//                         'https://placehold.co/350x300',
//                     fit: BoxFit.cover,
//                     height: 300,
//                     width: double.infinity,
//                   ),
//                 ),

//                 //Rating Badge (Top Left)
//                 // Positioned(
//                 //   top: 15,
//                 //   left: 15,
//                 //   child: Container(
//                 //     padding: const EdgeInsets.symmetric(
//                 //       horizontal: 8,
//                 //       vertical: 4,
//                 //     ),
//                 //     decoration: BoxDecoration(
//                 //       color: Colors.black.withOpacity(0.5),
//                 //       borderRadius: BorderRadius.circular(20),
//                 //       border: Border.all(
//                 //         color: const Color.fromRGBO(234, 249, 153, 1),
//                 //         width: 1,
//                 //       ),
//                 //     ),
//                 //     child: Row(
//                 //       children: [
//                 //         const Icon(Icons.star, color: Colors.amber, size: 20),
//                 //         const SizedBox(width: 4),
//                 //         Text(
//                 //           (widget.event['event_rating'] ?? 0).toString(),
//                 //           style: const TextStyle(
//                 //             fontWeight: FontWeight.bold,
//                 //             color: Colors.white,
//                 //           ),
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),

//                 // Like Button (Top Right)
//                 Positioned(
//                   top: 15,
//                   right: 15,
//                   child: GestureDetector(
//                     onTap: () {
//                       // This setState now only rebuilds THIS single card
//                       setState(() {
//                         _isLiked = !_isLiked;
//                       });
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 8,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.5),
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                           color: const Color.fromRGBO(234, 249, 153, 1),
//                           width: 1,
//                         ),
//                       ),
//                       child: Icon(
//                         _isLiked ? Icons.favorite : Icons.favorite_border,
//                         color: Colors.amber,
//                         size: 22,
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Text Content (Bottom)
//                 Positioned(
//                   bottom: 0,
//                   left: 0,
//                   right: 0,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 16,
//                     ),
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(
//                         255,
//                         242,
//                         0,
//                         0,
//                       ).withOpacity(0.5),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.event['event_name'] ?? 'No Name',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 18,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Row(
//                           children: [
//                             const Icon(
//                               Icons.location_on,
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                             const SizedBox(width: 5),
//                             Text(
//                               widget.event['event_city'] != null &&
//                                       widget.event['event_city']
//                                           .toString()
//                                           .contains('Virtual')
//                                   ? 'Virtual Event'
//                                   : '${widget.event['event_city'] ?? 'No City'}, ${widget.event['event_country'] ?? 'No Country'}',
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:golocal/components/bottomNavigation.dart';
import 'package:golocal/supabase/event/event_supabase.dart';

class Eventcarditem extends StatefulWidget {
  final EventSupabase event;

  const Eventcarditem({super.key, required this.event});

  @override
  State<Eventcarditem> createState() => _EventcarditemState();
}

class _EventcarditemState extends State<Eventcarditem> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: SizedBox(
        width: 350,
        child: GestureDetector(
          onTap: () {
            BottomNavigation.navigateToEvent(widget.event);
          },
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              // Add this ClipRRect
              borderRadius: BorderRadius.circular(20), // With the same radius
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.event.eventImage ?? 'https://placehold.co/350x300',
                      fit: BoxFit.cover,
                      height: 330,
                      width: double.infinity,
                    ),
                  ),

                  Positioned(
                    top: 15,
                    right: 15,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isLiked = !_isLiked;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color.fromRGBO(234, 249, 153, 1),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          _isLiked ? Icons.favorite : Icons.favorite_border,
                          color: Colors.amber,
                          size: 22,
                        ),
                      ),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.event.eventName ?? 'No Name',
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
                                widget.event.eventCity != null &&
                                        widget.event.eventCity!
                                            .toString()
                                            .contains('Virtual')
                                    ? 'Virtual Event'
                                    : '${widget.event.eventCity ?? 'No City'}, ${widget.event.eventCountry ?? 'No Country'}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
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
            ), // End of ClipRRect
          ),
        ),
      ),
    );
  }
}
