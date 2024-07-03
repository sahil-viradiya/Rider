class Ride {
  int? rideId;
  String? pickUpLatitude;
  String? pickUpLongitude;
  String? pickupAddress;
  String? senderLandmark;
  String? senderName;
  int? senderMobileNo;
  String? dropOffLatitude;
  String? dropOffLongitude;
  String? dropAddress;
  String? receiverLandmark;
  String? receiverName;
  int? receiverMobileNo;
  String? addressType;
  String? totalDistance;
  String? totalTime;
  String? unitCharge;
  String? totalCharges;
  String? createdDateTime;

  Ride(
      {this.rideId,
      this.pickUpLatitude,
      this.pickUpLongitude,
      this.pickupAddress,
      this.senderLandmark,
      this.senderName,
      this.senderMobileNo,
      this.dropOffLatitude,
      this.dropOffLongitude,
      this.dropAddress,
      this.receiverLandmark,
      this.receiverName,
      this.receiverMobileNo,
      this.addressType,
      this.totalDistance,
      this.totalTime,
      this.unitCharge,
      this.totalCharges,
      this.createdDateTime});

  Ride.fromJson(Map<String, dynamic> json) {
    rideId = json['ride_id'];
    pickUpLatitude = json['pickUpLatitude'];
    pickUpLongitude = json['pickUpLongitude'];
    pickupAddress = json['pickup_address'];
    senderLandmark = json['sender_landmark'];
    senderName = json['sender_name'];
    senderMobileNo = json['sender_mobile_no'];
    dropOffLatitude = json['dropOffLatitude'];
    dropOffLongitude = json['dropOffLongitude'];
    dropAddress = json['drop_address'];
    receiverLandmark = json['receiver_landmark'];
    receiverName = json['receiver_name'];
    receiverMobileNo = json['receiver_mobile_no'];
    addressType = json['address_type'];
    totalDistance = json['totalDistance'];
    totalTime = json['totalTime'];
    unitCharge = json['unit_charge'];
    totalCharges = json['totalCharges'];
    createdDateTime = json['createdDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ride_id'] = rideId;
    data['pickUpLatitude'] = pickUpLatitude;
    data['pickUpLongitude'] = pickUpLongitude;
    data['pickup_address'] = pickupAddress;
    data['sender_landmark'] = senderLandmark;
    data['sender_name'] = senderName;
    data['sender_mobile_no'] = senderMobileNo;
    data['dropOffLatitude'] = dropOffLatitude;
    data['dropOffLongitude'] = dropOffLongitude;
    data['drop_address'] = dropAddress;
    data['receiver_landmark'] = receiverLandmark;
    data['receiver_name'] = receiverName;
    data['receiver_mobile_no'] = receiverMobileNo;
    data['address_type'] = addressType;
    data['totalDistance'] = totalDistance;
    data['totalTime'] = totalTime;
    data['unit_charge'] = unitCharge;
    data['totalCharges'] = totalCharges;
    data['createdDateTime'] = createdDateTime;
    return data;
  }
}
