import 'package:flutter/material.dart';
import 'package:fitmate/home/home.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Map<String, String>> onboardingData = [
    {
      'title': 'Welcome to FitMate',
      'subtitle': 'Track your workouts and stay fit',
      'color': '#2ecc71',
    },
    {
      'title': 'Create your own workout plan',
      'subtitle': 'Choose from our library of exercises',
      'color': '#f39c12',
    },
    {
      'title': 'Connect with friends and share your progress',
      'subtitle': 'Motivate each other to achieve your goals',
      'color': '#3498db',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            // Swipe to right
            if (_currentPage == 0) return;
            _pageController.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else if (details.primaryVelocity! < 0) {
            // Swipe to left
            if (_currentPage == onboardingData.length - 1) return;
            _pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                  itemCount: onboardingData.length,
                  itemBuilder: (context, index) {
                    return OnboardingPage(
                      title: onboardingData[index]['title']!,
                      subtitle: onboardingData[index]['subtitle']!,
                      color: onboardingData[index]['color']!,
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingData.length,
                  (index) => buildDots(index, context),
                ),
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _currentPage == onboardingData.length - 1
                    ? ElevatedButton(
                        onPressed: () {
                          // navigate to the next screen
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                        child: Text('Get started'),
                      )
                    : TextButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text('Next'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildDots(int index, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      height: 10,
      width: _currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: _currentPage == index
            ? Theme.of(context).primaryColor
            : Colors.grey[400],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String color;

  const OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000),
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          Image.asset(
            'assets/images/fitness_logo.png',
            height: 200,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
