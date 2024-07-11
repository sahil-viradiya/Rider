class RideAcceptModel {
  int? orderId;
  String? rideStatus;
  String? deliveryTime;
  String? deliveryAddress;
  String? itemDetails;

  RideAcceptModel(
      {this.orderId,
      this.rideStatus,
      this.deliveryTime,
      this.deliveryAddress,
      this.itemDetails});

  RideAcceptModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    rideStatus = json['ride_status'];
    deliveryTime = json['delivery_time'];
    deliveryAddress = json['delivery_address'];
    itemDetails = json['item_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['ride_status'] = rideStatus;
    data['delivery_time'] = deliveryTime;
    data['delivery_address'] = deliveryAddress;
    data['item_details'] = itemDetails;
    return data;
  }
}
