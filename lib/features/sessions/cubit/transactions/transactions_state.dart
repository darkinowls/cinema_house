part of 'transactions_cubit.dart';

class TransactionsState extends Equatable {
  final int sessionId;
  final CardForm cardForm;
  final Iterable<int> seatIds;

  const TransactionsState(
      {required this.sessionId,
      this.cardForm = const CardForm.empty(),
      required this.seatIds});

  @override
  List<Object> get props => [sessionId, cardForm, seatIds];

  TransactionsState copyWith({
    int? sessionId,
    CardForm? cardForm,
    Iterable<int>? seatIds,
  }) {
    return TransactionsState(
      sessionId: sessionId ?? this.sessionId,
      cardForm: cardForm ?? this.cardForm,
      seatIds: seatIds ?? this.seatIds,
    );
  }
}
