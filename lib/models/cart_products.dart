import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CartProducts {
  String name, image;
  int price, id, qty;
  CartProducts(
      {required this.name,
      required this.price,
      required this.image,
      required this.id,
      required this.qty});
}

class Total {
  int subtotal;
  Total({required this.subtotal});
}
class getTotal {
  double get subTotal => cart_products.fold(
      0, (total, current) => total + (current.price * current.qty));

  String get subTotalString => subTotal.toString();

  double deliveryFee() {
    if (subTotal >= 100.0) {
      return 0;
    } else {
      return 20;
    }
  }
  double tax() {
    return subTotal * 15 /100;
  }
  double total() {
    return subTotal + deliveryFee() + tax();
  }
}
List<CartProducts> cart_products = [];
class CartProductManager extends Equatable {

  // List<CartProducts> p = [];
  List<int> totalPrices = [];
  // // var totalPrices = [];
  int t = 0;
  // double get s =>
  //     cart_products.fold(0, (total, current) => total + current.price);
  // String get subtotalString => s.toStringAsFixed(2);

  List<CartProducts> p = [
    CartProducts(
        name: 'hello',
        price: 14,
        image: 'assets/images/cake1.jpg',
        id: 0,
        qty: 1),
    CartProducts(
        name: 'hello',
        price: 12,
        image: 'assets/images/cake1.jpg',
        id: 1,
        qty: 1),
  ];
  Future getCartProductList(userId) async {
    final CollectionReference productsItems = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection("cart");
    try {
      cart_products.clear();
      var snapshot = await productsItems.get();
      snapshot.docs.forEach((element) {
        Map<String, dynamic>? data = element.data() as Map<String, dynamic>?;
        if (data != null) {
          var item = CartProducts(
              name: 'hello',
              price: 14,
              image: 'assets/images/cake1.jpg',
              id: 0,
              qty: 1);
          item.name = data['name'];
          item.price = data['price'];
          item.image = data['image'];
          item.id = data['id'];
          item.qty = data['qty'];
          t = t + item.price * item.qty;

          cart_products.add(item);
        } else {
          print("error:");
        }
      });
      //t =t+ calculateTotal();
      //print("11/:,${calculateTotal()}");
      print("t:::${t}");

      return (cart_products);
    } catch (e) {
      print("Error : ${e.toString()}");
      return [];
    }
  }

  int calculateTotal() {
    int subtotal = 0;

    for (var i = 0; i < totalPrices.length; i++) {
      subtotal = subtotal + totalPrices[i];
    }
    //item.subtotal = subtotal;
    print("subtotal1:${subtotal},${totalPrices}");

    return subtotal;
  }

  // int get subtotal => calculateTotal();


  @override
  // TODO: implement props
  List<Object?> get props => [];
}
