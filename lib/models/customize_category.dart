import 'package:equatable/equatable.dart';

class Category extends Equatable{
  final String name;
  final String image;

  const Category({
    required this.name,
    required this.image,
});
  @override
  // TODO: implement props
  List<Object?> get props => [name, image];
  static List<Category> custom_types =[
    Category(name: 'Regular', image: 'assets/images/cake_one.jpeg'),
    Category(name: 'Vegan', image: 'assets/images/cake_two.jpeg'),
    Category(name: 'Gluten Free', image: 'assets/images/cake_three.jpeg'),
    Category(name: 'Sugar Free', image: 'assets/images/cake_four.jpeg'),

  ];
  static List<Category> custom_shapes =[
    Category(name: 'Hexagon', image: 'assets/images/cake_five.jpeg'),
    Category(name: 'Heart', image: 'assets/images/cake_six.jpeg'),
    Category(name: 'Round', image: 'assets/images/cake_seven.jpeg'),
    Category(name: 'Square', image: 'assets/images/cake_square.jpeg'),
  ];

  static List<Category> custom_sizes =[
    Category(name: '0.5 lbs', image: 'assets/images/cake_size1.jpeg'),
    Category(name: '1.0 lbs', image: 'assets/images/cake_size2.png'),
    Category(name: '1.5 lbs', image: 'assets/images/cake_size3.jpeg'),
    Category(name: '2.0 lbs', image: 'assets/images/cake_size4.jpeg'),
  ];

  static List<Category> custom_falvours =[
    Category(name: 'Almond', image: 'assets/images/cake_almond.jpg'),
    Category(name: 'Strawberry', image: 'assets/images/cake_strawberry.jpeg'),
    Category(name: 'Vanilla', image: 'assets/images/cake_vanilla.jpeg'),
    Category(name: 'Chocolate', image: 'assets/images/cake_choco.png'),
  ];

  static List<Category> custom_designs =[
    Category(name: 'Makeup', image: 'assets/images/cake_makeup.jpeg'),
    Category(name: 'Doll', image: 'assets/images/cake_barbie.jpeg'),
    Category(name: 'Swan', image: 'assets/images/cake_swan.png'),
    Category(name: 'Teddy', image: 'assets/images/cake_teddy.jpeg'),
  ];
}