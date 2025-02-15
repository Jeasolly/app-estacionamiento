class Pago {
  final String plate;
  final String cardNo;
  final double amount;
  final int payTime;

  Pago({
    required this.plate,
    required this.cardNo,
    required this.amount,
    required this.payTime,
  });

  Map<String, dynamic> toJson() {
    return {
      "plate": plate,
      "cardNo": cardNo,
      "payTime": payTime,
      "amount": amount,
      "deleteOnsiteCar": 0,
    };
  }
}
