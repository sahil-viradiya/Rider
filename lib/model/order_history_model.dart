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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['ride_status'] = this.rideStatus;
    data['order_time'] = this.orderTime;
    data['ride_date'] = this.rideDate;
    data['delivery_time'] = this.deliveryTime;
    data['delivery_address'] = this.deliveryAddress;
    data['order_pick_up_time'] = this.orderPickUpTime;
    data['order_picked_up_at'] = this.orderPickedUpAt;
    data['item_details'] = this.itemDetails;
    return data;
  }
}
