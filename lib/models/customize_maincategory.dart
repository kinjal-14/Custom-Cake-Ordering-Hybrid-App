import 'package:equatable/equatable.dart';

class MainCategory extends Equatable{
  final String name;
  const MainCategory({
    required this.name,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [name];
  static List<MainCategory> custom_maincategory =[
    MainCategory(name: 'Type'),
    MainCategory(name: 'Shape'),
    MainCategory(name: 'Size'),
    MainCategory(name: 'Flavour'),
    MainCategory(name: 'Design'),

  ];

}