import 'package:fitmate/model/course.dart';
import 'package:flutter/material.dart';
import '../model/db_helper.dart';

class DbController extends ChangeNotifier {
  DbController() {
    getAllCourses();
  }
  List<Course> courses = [];
  List<Course> result = [];

  bool isLoading = false;
  flipIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  getAllCourses() async {
    flipIsLoading();
    courses = await DbHelper.dbHelper.getAllCourses();
    flipIsLoading();
  }

  TextEditingController imageController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  createCourse(title, image, description, price) async {
    print("adding new course ${title} : ${price}");
    Course course = Course(
        image: image,
        title: title,
        description: description,
        price: double.parse(price));
    await DbHelper.dbHelper.insertNewCourse(course);
    getAllCourses();
  }

  // updateCourse(int id) async {

  // }

  getCourseByTitle(String query) async {
    result = [await DbHelper.dbHelper.getCourseByTitle(query)];
    print("search for... ${result[0].price}");
  }

  deleteCourse(int id) async {
    await DbHelper.dbHelper.deleteCourse(id);
    courses.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
