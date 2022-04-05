class CartModel {
  String? id;
  String? image;
  String? name;
  int? qty;
  int? price;
  String? type;
  String? customType;
  String? shape;
  String? size;
  String? flavour;
  String? design;
  String? note;

  CartModel({this.id, this.image, this.name, this.qty, this.price,this.type,this.size,this.design,this.shape,this.flavour,this.customType,this.note});

  // receiving  data from server
  factory CartModel.fromMap(map){
    return CartModel(
      id: map['id'],
      image: map['image'],
      name: map['name'],
      qty: map['qty'],
      price: map['price'],
      type: map['type'],
      customType: map['customType'],
      shape: map['shape'],
      size: map['size'],
      flavour: map['flavour'],
      design: map['design'],
      note: map['note'],
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
      'customType' : customType,
      'shape' : shape,
      'size' : size,
      'flavour' : flavour,
      'design' : design,
      'note' : note,

    };
  }
}