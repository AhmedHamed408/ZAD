class UserModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String nationalId;
  final String birthDate;
  final String profileImage;
  final double balance;
  final String currency;
  final String location;
  final String? address;
  final bool isOnline;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.nationalId,
    required this.birthDate,
    required this.profileImage,
    required this.balance,
    required this.currency,
    required this.location,
    this.address,
    this.isOnline = false,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? nationalId,
    String? birthDate,
    String? profileImage,
    double? balance,
    String? currency,
    String? location,
    String? address,
    bool? isOnline,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      nationalId: nationalId ?? this.nationalId,
      birthDate: birthDate ?? this.birthDate,
      profileImage: profileImage ?? this.profileImage,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      location: location ?? this.location,
      address: address ?? this.address,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}
