import 'dart:developer';
import './course.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();
  static DbHelper dbHelper = DbHelper._();
  late Database database;
  initDatabase() async {
    String appPath = await getDatabasesPath();
    String dbPath = appPath + '/fitmate.db';
    database = await openDatabase(dbPath, version: 2, onCreate: (db, v) {
      db.execute(
          'CREATE TABLE courses (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT,image TEXT, description TEXT, price REAL)');
    });
    // for (var course in Course.courses) {
    //   insertNewCourse(course);
    // }
  }

  insertNewCourse(Course course) async {
    try {
      int rowNumber = await database.insert('courses', course.toMap());
      log("row number ${rowNumber.toString()}");
      return rowNumber.toString();
    } catch (e) {
      log("error ${e.toString()}");
      log("row has not been inserted");
      return -1;
    }
  }

  Future<List<Course>> getAllCourses() async {
    await Future.delayed(const Duration(seconds: 3));
    List<Map> results = await database.query('courses');
    List<Course> courses = results.map((e) => Course.fromMap(e)).toList();
    return courses;
  }

  Future<List<Course>> getCourseById(int id) async {
    List<Map> results = await database.query('courses', where: 'title=card');
    print("search results... $results");
    List<Course> courses = results.map((e) => Course.fromMap(e)).toList();
    return courses;
  }

  Future<Course> getCourseByTitle(String title) async {
    List<Map> results =
        await database.rawQuery('SELECT * FROM courses WHERE title=?', [title]);
    print("result111 ${results.first}");
    var course = Course.fromMap(results.first);
    return course;
  }

  deleteCourse(int id) async {
    await database.delete('courses', where: 'id=$id');
  }

  updateCourse(Course course) async {
    await database.update('courses', course.toMap(), where: 'id=${course.id}');
  }
}
