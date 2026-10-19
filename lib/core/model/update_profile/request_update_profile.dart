class RequestUpdateProfile {
  final String? email;
  final String? fullName;
  final String? userName;
  final String? address;
  final String? profileImage;

  RequestUpdateProfile({
    this.email,
    this.fullName,
    this.userName,
    this.address,
    this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'fullName': fullName,
      'userName': userName,
      'address': address,
      'profileImage': profileImage,
    };
  }

  factory RequestUpdateProfile.fromJson(Map<String, dynamic> json) {
    return RequestUpdateProfile(
      email: json['email'],
      fullName: json['fullName'],
      userName: json['userName'],
      address: json['address'],
      profileImage: json['profileImage'],
    );
  }
}
