class StartRideModel {
  int? orderID;
  String? customerName;
  String? pickUpLatitude;
  String? pickUpLongitude;
  String? dropOffLatitude;
  String? dropOffLongitude;
  String? deliveryTime;
  String? deliveryAddress;

  StartRideModel(
      {this.orderID,
      this.customerName,
      this.pickUpLatitude,
      this.pickUpLongitude,
      this.dropOffLatitude,
      this.dropOffLongitude,
      this.deliveryTime,
      this.deliveryAddress});

  StartRideModel.fromJson(Map<String, dynamic> json) {
    orderID = json['Order ID'];
    customerName = json['Customer Name'];
    pickUpLatitude = json['pickUpLatitude'];
    pickUpLongitude = json['pickUpLongitude'];
    dropOffLatitude = json['dropOffLatitude'];
    dropOffLongitude = json['dropOffLongitude'];
    deliveryTime = json['Delivery Time'];
    deliveryAddress = json['Delivery Address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Order ID'] = orderID;
    data['Customer Name'] = customerName;
    data['pickUpLatitude'] = pickUpLatitude;
    data['pickUpLongitude'] = pickUpLongitude;
    data['dropOffLatitude'] = dropOffLatitude;
    data['dropOffLongitude'] = dropOffLongitude;
    data['Delivery Time'] = deliveryTime;
    data['Delivery Address'] = deliveryAddress;
    return data;
  }
}
