class OrderHistoryModel {
  int? orderId;
  String? rideStatus;
  String? orderTime;
  String? rideDate;
  String? deliveryAddress;
  String? orderPickUpTime;
  String? orderPickedUpAt;
  String? deliveryTime;
  String? itemDetails;

  OrderHistoryModel(
      {this.orderId,
      this.rideStatus,
      this.orderTime,
      this.rideDate,
      this.deliveryAddress,
      this.orderPickUpTime,
      this.deliveryTime,
      this.orderPickedUpAt,
      this.itemDetails});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    rideStatus = json['ride_status'];
    deliveryTime = json['delivery_time'];
    orderTime = json['order_time'];
    rideDate = json['ride_date'];
    deliveryAddress = json['delivery_address'];
    orderPickUpTime = json['order_pick_up_time'];
    orderPickedUpAt = json['order_picked_up_at'];
    itemDetails = json['item_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['ride_status'] = rideStatus;
    data['order_time'] = orderTime;
    data['ride_date'] = rideDate;
    data['delivery_time'] = deliveryTime;
    data['delivery_address'] = deliveryAddress;
    data['order_pick_up_time'] = orderPickUpTime;
    data['order_picked_up_at'] = orderPickedUpAt;
    data['item_details'] = itemDetails;
    return data;
  }
}
