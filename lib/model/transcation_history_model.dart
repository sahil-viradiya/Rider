class TranscationHistoryModel {
  int? id;
  int? userId;
  String? transactionId;
  int? amount;
  String? type;

  TranscationHistoryModel(
      {this.id, this.userId, this.transactionId, this.amount, this.type});

  TranscationHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    transactionId = json['transaction_id'];
    amount = json['amount'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['transaction_id'] = transactionId;
    data['amount'] = amount;
    data['type'] = type;
    return data;
  }
}
