import 'package:fitmate/controller/db_controller.dart';
import 'package:fitmate/home/card.dart';
import 'package:fitmate/home/home.dart';
import 'package:fitmate/model/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Form/add_screen.dart';
import '../profile/profile.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchText = '';
  int _selectedIndex = 0;
  final dbController = new DbController();

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
      } else if (index == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            setState(() {
              _searchText = value;
              dbController.getCourseByTitle(_searchText);
            });
          },
        ),
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
                      child: Text("No Result has been found"),
                    )
                  : ListView.builder(
                      itemCount: controller.result.length,
                      itemBuilder: (context, index) {
                        return CardWidget(
                          id: controller.result[0].id!,
                          image: controller.result[0].image!,
                          title: controller.result[0].title,
                          price: controller.result[0].price,
                          description: controller.result[0].description,
                        );
                      });
        },
      ),
    );
  }
}
