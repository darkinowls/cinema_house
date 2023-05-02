class BookSeats {
  late final List<int> seats;
  late final int sessionId;

  BookSeats({required this.seats, required this.sessionId});

  BookSeats.fromJson(Map<String, dynamic> json) {
    seats = json['seats'].cast<int>();
    sessionId = json['sessionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seats'] = seats;
    data['sessionId'] = sessionId;
    return data;
  }
}
