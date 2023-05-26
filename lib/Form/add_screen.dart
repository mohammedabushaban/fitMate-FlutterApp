import 'package:fitmate/controller/db_controller.dart';
import 'package:fitmate/model/course.dart';
import 'package:fitmate/model/db_helper.dart';
import 'package:fitmate/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home/home.dart';
import '../search/search_screen.dart';
import '../widgets/MyDialog.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  int _selectedIndex = 1;
  final dbController = DbController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else if (index == 3) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
      } else if (index == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SearchScreen()),
        );
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _price;
  late String _imageUrl;
  late String _description;
  late String _body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Item'),
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
            return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: controller.titleController,
                              decoration: InputDecoration(labelText: 'Title'),
                              onSaved: (value) => _title = value!,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a title';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Price'),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a price';
                                }
                                if (double.tryParse(value) == null) {
                                  return 'Please enter a valid price';
                                }
                                return null;
                              },
                              controller: controller.priceController,
                              onSaved: (value) => _price = value!,
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Image URL'),
                              keyboardType: TextInputType.url,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an image URL';
                                }
                                if (!Uri.parse(value).isAbsolute) {
                                  return 'Please enter a valid image URL';
                                }
                                return null;
                              },
                              controller: controller.imageController,
                              onSaved: (value) => _imageUrl = value!,
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Description'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a description';
                                }
                                return null;
                              },
                              controller: controller.descriptionController,
                              onSaved: (value) => _description = value!,
                            ),
                            SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: _submitForm,
                              child: Text('Add Item'),
                            ),
                          ],
                        ),
                      ),
                    ));
          },
        ));
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      dbController.createCourse(_title, _imageUrl, _description, _price);
      MyDialog.showSuccessDialog(context);
    }
  }
}
