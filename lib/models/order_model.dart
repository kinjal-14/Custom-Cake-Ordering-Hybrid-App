class OrderModel {
  String? id;
  String? subtotal;
  String? delivery;
  String? tax;
  String? total;
  String? address1;
  String? address2;
  String? postalCode;
  String? city;
  String? state;
  String? orderType;

  OrderModel(
      {this.id,
      this.subtotal,
      this.state,
      this.city,
      this.postalCode,
      this.address2,
      this.address1,
      this.delivery,
      this.total,
      this.tax,
      this.orderType});

  // receiving  data from server
  factory OrderModel.fromMap(map) {
    return OrderModel(
      id: map['id'],
      subtotal: map['subtotal'],
      tax: map['tax'],
      delivery: map['delivery'],
      total: map['total'],
      address1: map['address1'],
      address2: map['address2'],
      city: map['city'],
      postalCode: map['postalCode'],
      state: map['state'],
      orderType: map['orderType'],
    );
  }
//sending data to server
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subtotal': subtotal,
      'delivery': delivery,
      'tax': tax,
      'total': total,
      'address1': address1,
      'address2': address2,
      'city': city,
      'postalCode': postalCode,
      'state': state,
      'orderType': orderType
    };
  }
}
