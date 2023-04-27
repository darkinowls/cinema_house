class PhoneNumber {
  late String phoneNumber;

  PhoneNumber({required this.phoneNumber});

  PhoneNumber.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
