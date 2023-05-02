import 'package:cinema_house/features/sessions/domain/entities/card_form.dart';

class BuySeats extends CardForm {
  late final List<int> seats;
  late final int sessionId;

  BuySeats(
      {required this.seats,
      required this.sessionId,
      required super.email,
      required super.cardNumber,
      required super.expirationDate,
      required super.cvv});

  factory BuySeats.fromJson(Map<String, dynamic> json) {
    return BuySeats(
        seats: json['seats'].cast<int>(),
        sessionId: json['sessionId'],
        email: json['email'],
        cardNumber: json['cardNumber'],
        expirationDate: json['expirationDate'],
        cvv: json['cvv']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seats'] = seats;
    data['sessionId'] = sessionId;
    data['email'] = email;
    data['cardNumber'] = cardNumber;
    data['expirationDate'] = expirationDate;
    data['cvv'] = cvv;
    return data;
  }
}
