class UserProfile {
  final String name;
  final String email;
  final String mobileNumber;
  final String gender;
  final String birthDate;
  final Country country;
  final List<String> interests;
  final String imageUrl;

  UserProfile({
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.gender,
    required this.birthDate,
    required this.country,
    required this.interests,
    required this.imageUrl,
  });
}

class Country {
  final String name;

  Country({
    required this.name,
  });
}