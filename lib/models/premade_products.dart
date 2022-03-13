import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

// class PreMadeProducts extends Equatable{
//   final String image;
//   final String name;
//   final String price;
//   const PreMadeProducts({
// this.image,
//     this.name,
//    this.price,
//   });
//   @override
//   // TODO: implement props
//   List<Object?> get props => [image,name,price];
//
//   static List<PreMadeProducts> products =[
//     PreMadeProducts(image: 'assets/images/cake17.jpg',name:"cake1",price:"150"),
//     PreMadeProducts(image: 'assets/images/cake2.jpg',name:"cake2",price:"100"),
//     PreMadeProducts(image: 'assets/images/cake4.jpg',name:"cake3",price:"150"),
//     PreMadeProducts(image: 'assets/images/cake5.jpg',name:"cake4",price:"250"),
//     PreMadeProducts(image: 'assets/images/cake17.jpg',name:"cake5",price:"350"),
//     PreMadeProducts(image: 'assets/images/cake1.jpg',name:"cake1",price:"150"),
//     PreMadeProducts(image: 'assets/images/cake2.jpg',name:"cake2",price:"100"),
//     PreMadeProducts(image: 'assets/images/cake4.jpg',name:"cake3",price:"150"),
//     PreMadeProducts(image: 'assets/images/cake5.jpg',name:"cake4",price:"250"),
//     PreMadeProducts(image: 'assets/images/cake17.jpg',name:"cake5",price:"350"),
//
//   ];
//
// }
class PreMadeProducts {
  String name, image, size;
  int price, id;
  PreMadeProducts(
      {required this.name, required this.price, required this.image, required this.id, required this.size});
}

class ProductManager{
  List<PreMadeProducts> products = [];
  Future getProductList(sort) async {
    final CollectionReference productsItems =
        FirebaseFirestore.instance.collection('products');
    try {
      products.clear();
      var snapshot = await productsItems.orderBy(sort, descending: false).get();
      snapshot.docs.forEach((element) {
        Map<String, dynamic>? data = element.data() as Map<String, dynamic>?;
        if (data != null) {
          var item = PreMadeProducts(
              name: 'hello', price: 14, image: 'assets/images/cake1.jpg',id:0,size: "");
          item.name = data['name'];
          item.price = data['price'];
          item.image = data['image'];
          item.id = data['id'];
          item.size = data['size'];
          products.add(item);
        } else {
          print("error:");
        }
      });
      return products;
    } catch (e) {
      print("Error : ${e.toString()}");
      return [];
    }

  }

}

class SingleProduct {
  int? id;
  int? price;
  String? name;
  String? desc;
  String? image;
  String? size;
  String? calories;

  SingleProduct({this.id, this.price, this.name, this.desc, this.image,this.size,this.calories});

  // receiving  data from server
  factory SingleProduct.fromMap(map){
    return SingleProduct(
      id: map['id'],
      price: map['price'],
      name: map['name'],
      desc: map['desc'],
      image: map['image'],
      size: map['size'],
      calories: map['calories'],
    );
  }

}
