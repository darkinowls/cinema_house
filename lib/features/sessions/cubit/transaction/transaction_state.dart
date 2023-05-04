part of 'transaction_cubit.dart';


class TransactionState extends Equatable {
  final Status status;
  final int sessionId;
  final Iterable<int> seatIds;
  final String errorMessage;

  const TransactionState(
      {this.status = Status.loaded,
      this.errorMessage = "",
      required this.sessionId,
      required this.seatIds});

  TransactionState copyWith({
    Status? status,
    int? sessionId,
    Iterable<int>? seatIds,
    String? errorMessage,
  }) {
    return TransactionState(
      status: status ?? this.status,
      sessionId: sessionId ?? this.sessionId,
      seatIds: seatIds ?? this.seatIds,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        sessionId,
        seatIds,
        errorMessage,
      ];
}
