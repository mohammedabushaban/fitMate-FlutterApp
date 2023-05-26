import 'package:fitmate/controller/db_controller.dart';
import 'package:fitmate/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Form/add_screen.dart';
import '../profile/profile.dart';
import 'card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2;
  final dbController = DbController();

  // Refresh method
  void refreshPage() {
    // Add your refresh logic here
    setState(() {
      // Update any necessary state variables or reload data
      dbController.getAllCourses();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 3) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
      } else if (index == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AddScreen()),
        );
      } else if (index == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SearchScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fit Mate'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).accentColor,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: Consumer<DbController>(
        builder: (context, controller, x) {
          return controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : controller.courses.isEmpty
                  ? Center(
                      child:
                          Text("There is no available courses at the moment"),
                    )
                  : ListView.builder(
                      itemCount: controller.courses.length,
                      itemBuilder: (context, index) {
                        return CardWidget(
                          id: controller.courses[index].id!,
                          image: controller.courses[index].image!,
                          title: controller.courses[index].title,
                          price: controller.courses[index].price,
                          description: controller.courses[index].description,
                        );
                      });
        },
      ),
    );
  }
}
