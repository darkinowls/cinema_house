import 'package:cinema_house/features/sessions/data/models/buy_seats.dart';

class CardForm {
  String email;
  String cardNumber;
  String expirationDate;
  String cvv;

  CardForm({
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
