import 'package:fitmate/home/home.dart';
import 'package:fitmate/model/db_helper.dart';
import 'package:flutter/material.dart';

class DeleteDialog {
  static void showDeleteDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ALERT'),
          content: Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                DbHelper.dbHelper.deleteCourse(id);
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text("Cancel"))
          ],
        );
      },
    );
  }
}
