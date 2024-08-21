class Ride {
  int? rideId;
  String? orderId;
  String? rideStatus;
  String? deliveryAddress;
  String? itemDetails;
  String? pickUpLatitude;
  String? pickUpLongitude;
  String? pickupAddress;
  String? senderName;
  String? senderMobileNo;
  String? senderLandmark;
  String? dropOffLatitude;
  String? dropOffLongitude;
  String? dropAddress;
  String? receiverName;
  String? receiverMobileNo;
  String? receiverLandmark;
  String? addressType;
  String? totalDistance;
  String? totalTime;
  String? unitCharge;
  int? totalCharges;

  Ride(
      {this.rideId,
      this.orderId,
      this.rideStatus,
      this.deliveryAddress,
      this.itemDetails,
      this.pickUpLatitude,
      this.pickUpLongitude,
      this.pickupAddress,
      this.senderName,
      this.senderMobileNo,
      this.senderLandmark,
      this.dropOffLatitude,
      this.dropOffLongitude,
      this.dropAddress,
      this.receiverName,
      this.receiverMobileNo,
      this.receiverLandmark,
      this.addressType,
      this.totalDistance,
      this.totalTime,
      this.unitCharge,
      this.totalCharges});

  Ride.fromJson(Map<String, dynamic> json) {
    rideId = json['ride_id'];
    orderId = json['order_id'];
    rideStatus = json['ride_status'];
    deliveryAddress = json['delivery_address'];
    itemDetails = json['item_details'];
    pickUpLatitude = json['pickUpLatitude'];
    pickUpLongitude = json['pickUpLongitude'];
    pickupAddress = json['pickup_address'];
    senderName = json['sender_name'];
    senderMobileNo = json['sender_mobile_no'];
    senderLandmark = json['senderLandmark'];
    dropOffLatitude = json['dropOffLatitude'];
    dropOffLongitude = json['dropOffLongitude'];
    dropAddress = json['drop_address'];
    receiverName = json['receiver_name'];
    receiverMobileNo = json['receiver_mobile_no'];
    receiverLandmark = json['receiver_landmark'];
    addressType = json['address_type'];
    totalDistance = json['totalDistance'];
    totalTime = json['totalTime'];
    unitCharge = json['unit_charge'];
    totalCharges = json['totalCharges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ride_id'] = rideId;
    data['order_id'] = orderId;
    data['ride_status'] = rideStatus;
    data['delivery_address'] = deliveryAddress;
    data['item_details'] = itemDetails;
    data['pickUpLatitude'] = pickUpLatitude;
    data['pickUpLongitude'] = pickUpLongitude;
    data['pickup_address'] = pickupAddress;
    data['sender_name'] = senderName;
    data['sender_mobile_no'] = senderMobileNo;
    data['senderLandmark'] = senderLandmark;
    data['dropOffLatitude'] = dropOffLatitude;
    data['dropOffLongitude'] = dropOffLongitude;
    data['drop_address'] = dropAddress;
    data['receiver_name'] = receiverName;
    data['receiver_mobile_no'] = receiverMobileNo;
    data['receiver_landmark'] = receiverLandmark;
    data['address_type'] = addressType;
    data['totalDistance'] = totalDistance;
    data['totalTime'] = totalTime;
    data['unit_charge'] = unitCharge;
    data['totalCharges'] = totalCharges;
    return data;
  }
}
