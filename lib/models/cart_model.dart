class CartModel {
  int? id;
  String? image;
  String? name;
  int? qty;
  int? price;
  String? type;

  CartModel({this.id, this.image, this.name, this.qty, this.price,this.type});

  // receiving  data from server
  factory CartModel.fromMap(map){
    return CartModel(
      id: map['id'],
      image: map['image'],
      name: map['name'],
      qty: map['qty'],
      price: map['price'],
      type: map['type'],
    );
  }
//sending data to server
  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'image' : image,
      'name' : name,
      'qty' : qty,
      'price' : price,
      'type' : type,
    };
  }
}