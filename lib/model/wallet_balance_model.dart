class WalletBalanceModel {
  int? driverId;
  int? driverWallet;
  int? driverReedomAmount;

  WalletBalanceModel(
      {this.driverId, this.driverWallet, this.driverReedomAmount});

  WalletBalanceModel.fromJson(Map<String, dynamic> json) {
    driverId = json['driver_id'];
    driverWallet = json['driver_wallet'];
    driverReedomAmount = json['driver_reedom_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['driver_id'] = driverId;
    data['driver_wallet'] = driverWallet;
    data['driver_reedom_amount'] = driverReedomAmount;
    return data;
  }
}
