import 'package:cinema_house/features/sessions/data/models/buy_seats.dart';

class CardForm {
  final String email;
  final String cardNumber;
  final String expirationDate;
  final String cvv;

  const CardForm({
    required this.email,
    required this.cardNumber,
    required this.expirationDate,
    required this.cvv,
  });

  const CardForm.empty({
    this.email = "",
    this.cardNumber = "",
    this.expirationDate = "",
    this.cvv = "",
  });

  BuySeats toBuySeats(List<int> seats, int sessionId) {
    return BuySeats(
        seats: seats,
        sessionId: sessionId,
        email: email,
        cardNumber: cardNumber,
        expirationDate: expirationDate,
        cvv: cvv);
  }

  bool isEmpty() {
    return email.isEmpty ||
        cardNumber.isEmpty ||
        expirationDate.isEmpty ||
        cvv.isEmpty;
  }
}
