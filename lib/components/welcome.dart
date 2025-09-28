import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:golocal/Components/Login-Signup/login.dart';
import 'package:golocal/Components/Login-Signup/signup.dart';

// Carousel Items that will be displayed in the welcome page
class CarouselItem {
  final String imagePath;
  final String title;
  final String description;

  CarouselItem({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

// List of Carousel Items
final List<CarouselItem> carouselData = [
  CarouselItem(
    imagePath: 'lib/images/new-york.jpeg',
    title: "See New York like a true local",
    description:
        "Itineraries curated by locals for an authentic New York experience.",
  ),
  CarouselItem(
    imagePath: 'lib/images/london.jpeg',
    title: "Find Your London Story",
    description: "Get insider travel maps and plans from those who live here",
  ),
  CarouselItem(
    imagePath: 'lib/images/europe.jpeg',
    title: "Go on a European adventure",
    description: "Travel Europe like a local with expert-made itineraries",
  ),
  CarouselItem(
    imagePath: 'lib/images/beach.jpeg',
    title: "Follow the Locals to the Shore",
    description: "Insider guides to the world’s best beaches and Caves",
  ),
];

class Welcomepage extends StatefulWidget {
  const Welcomepage({super.key});

  @override
  State<Welcomepage> createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < carouselData.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildCarouselItems(CarouselItem carouselItem) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(carouselItem.imagePath),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4),
                BlendMode.darken,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                carouselItem.title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                carouselItem.description,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          "Log In",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Sign Up",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigate to the SignUpPage when the text is tapped
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Signup(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: carouselData.length,
              itemBuilder: (context, index) {
                return _buildCarouselItems(carouselData[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
