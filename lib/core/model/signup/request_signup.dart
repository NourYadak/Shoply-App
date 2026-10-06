class RequestSignup {
  final String? email;
  final String? fullName;
  final String? userName;
  final String? address;
  final String? uid;
  final String? profileImage;

  RequestSignup({
    required this.email,
    required this.fullName,
    required this.userName,
    required this.address,
    this.uid,
    this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'fullName': fullName,
      'userName': userName,
      'address': address,
      'uid': uid,
      'profileImage': profileImage,
    };
  }

  factory RequestSignup.fromJson(Map<String, dynamic> json) {
    return RequestSignup(
      email: json['email'],
      fullName: json['fullName'],
      userName: json['userName'],
      address: json['address'],
      uid: json['uid'],
      profileImage: json['profileImage'],
    );
  }
}
