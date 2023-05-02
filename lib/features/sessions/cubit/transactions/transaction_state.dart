part of 'transaction_cubit.dart';

enum TransactionStatus { init, loading, failed, success }

class TransactionState extends Equatable {
  final TransactionStatus status;
  final int sessionId;
  final Iterable<int> seatIds;
  final String errorMessage;

  const TransactionState(
      {this.status = TransactionStatus.init,
      this.errorMessage = "",
      required this.sessionId,
      required this.seatIds});

  TransactionState copyWith({
    TransactionStatus? status,
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
