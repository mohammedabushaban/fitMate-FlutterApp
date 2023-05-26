import 'dart:developer';

class Course {
  Course({
    this.id = 0,
    this.image = '',
    required this.title,
    required this.description,
    required this.price,
  });

  int? id;
  String? image;
  String title = "";
  String description = "";
  double price = 0.0;

  Course.fromMap(Map map) {
    id = map["id"];
    image = map["image"];
    title = map["title"];
    description = map["description"];
    price = map["price"];
  }
  toMap() {
    return {
      "title": title,
      "description": description,
      "price": price,
      "image": image
    };
  }

  static List<Course> courses = <Course>[
    Course(
      image:
          'https://www.ihrsa.org/uploads/Articles/Column-Width/industry-news_muscular-bicep-dumbbell-stock_column.jpg',
      title: 'Card 1',
      description: 'This is the first card widget',
      price: 10.00,
    ),
    Course(
      image:
          'https://www.ihrsa.org/uploads/Articles/Column-Width/industry-news_muscular-bicep-dumbbell-stock_column.jpg',
      title: 'Card 2',
      description: 'This is the second card widget',
      price: 15.00,
    ),
    Course(
      image:
          'https://www.ihrsa.org/uploads/Articles/Column-Width/industry-news_muscular-bicep-dumbbell-stock_column.jpg',
      title: 'Card 3',
      description: 'This is the third card widget',
      price: 20.00,
    ),
    Course(
      image:
          'https://www.ihrsa.org/uploads/Articles/Column-Width/industry-news_muscular-bicep-dumbbell-stock_column.jpg',
      title: 'Card 4',
      description: 'This is the fourth card widget',
      price: 25.00,
    ),
    Course(
      image:
          'https://www.ihrsa.org/uploads/Articles/Column-Width/industry-news_muscular-bicep-dumbbell-stock_column.jpg',
      title: 'Card 5',
      description: 'This is the fifth card widget',
      price: 30.00,
    ),
    Course(
      image:
          'https://www.ihrsa.org/uploads/Articles/Column-Width/industry-news_muscular-bicep-dumbbell-stock_column.jpg',
      title: 'Card 6',
      description: 'This is the sixth card widget',
      price: 35.00,
    ),
    Course(
      image:
          'https://www.ihrsa.org/uploads/Articles/Column-Width/industry-news_muscular-bicep-dumbbell-stock_column.jpg',
      title: 'Card 7',
      description: 'This is the seventh card widget',
      price: 40.00,
    ),
    Course(
      image:
          'https://www.ihrsa.org/uploads/Articles/Column-Width/industry-news_muscular-bicep-dumbbell-stock_column.jpg',
      title: 'Card 8',
      description: 'This is the eighth card widget',
      price: 45.00,
    ),
    Course(
      image:
          'https://www.ihrsa.org/uploads/Articles/Column-Width/industry-news_muscular-bicep-dumbbell-stock_column.jpg',
      title: 'Card 9',
      description: 'This is the ninth card widget',
      price: 50.00,
    ),
    Course(
      image:
          'https://www.ihrsa.org/uploads/Articles/Column-Width/industry-news_muscular-bicep-dumbbell-stock_column.jpg',
      title: 'Card 10',
      description: 'This is the tenth card widget',
      price: 55.00,
    ),
  ];
}
