class RideAcceptModel {
  int? orderID;
  String? riderStatus;
  String? deliveryTime;
  String? deliveryAddress;
  String? itemDetails;

  RideAcceptModel(
      {this.orderID,
      this.riderStatus,
      this.deliveryTime,
      this.deliveryAddress,
      this.itemDetails});

  RideAcceptModel.fromJson(Map<String, dynamic> json) {
    orderID = json['Order ID'];
    riderStatus = json['Rider Status'];
    deliveryTime = json['Delivery Time'];
    deliveryAddress = json['Delivery Address'];
    itemDetails = json['Item Details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Order ID'] = orderID;
    data['Rider Status'] = riderStatus;
    data['Delivery Time'] = deliveryTime;
    data['Delivery Address'] = deliveryAddress;
    data['Item Details'] = itemDetails;
    return data;
  }
}
