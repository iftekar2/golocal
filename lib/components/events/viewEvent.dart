import 'package:flutter/material.dart';
import 'package:golocal/supabase/event/event_supabase.dart';

class Viewevent extends StatefulWidget {
  final EventSupabase event;
  const Viewevent({super.key, required this.event});

  @override
  State<Viewevent> createState() => _VieweventState();
}

class _VieweventState extends State<Viewevent> {
  bool _isLiked = false;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventImage = widget.event.eventImage is List<dynamic>
        ? List<String>.from(widget.event.eventImage as List<dynamic>)
        : (widget.event.eventImage != null &&
              widget.event.eventImage!.isNotEmpty)
        ? widget.event.eventImage!.split(',').map((url) => url.trim()).toList()
        : [];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.eventName ?? 'Event Details'),
        backgroundColor: const Color.fromRGBO(248, 247, 243, 1),
        forceMaterialTransparency: true,
      ),

      backgroundColor: const Color.fromRGBO(248, 247, 243, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 400,
                        width: 420,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: eventImage.length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                eventImage[index],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
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
                              );
                            },
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(eventImage.length, (index) {
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPage == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
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
                        child: Row(
                          children: [
                            Icon(
                              _isLiked ? Icons.favorite : Icons.favorite_border,
                              color: Colors.amber,
                              size: 22,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color.fromARGB(255, 207, 207, 207),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.event.eventName ?? "Event Name",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Color.fromARGB(255, 132, 131, 131),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 7),
                                  Text(
                                    "${widget.event.eventCity ?? ''}, ${widget.event.eventCountry ?? ''}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 132, 131, 131),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     const Icon(
                          //       Icons.star,
                          //       color: Colors.amber,
                          //       size: 20,
                          //     ),
                          //     const SizedBox(width: 5),
                          //     Text(
                          //       '${widget.event.rating?.toString() ?? 'N/A'} Ratings',
                          //       style: const TextStyle(
                          //         fontSize: 14,
                          //         color: Color.fromARGB(255, 109, 109, 109),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color.fromARGB(255, 207, 207, 207),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.event.eventDescription ??
                            'No description available.',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
