class UserProfile {
  final String name;
  final String email;
  final String mobileNumber;
  final String gender;
  final DateTime birth_date;
  final String? image;
  final String country;
  final List<String> interests;

  UserProfile({required this.country, required this.interests, this.image,required this.email, required this.mobileNumber, required this.gender, required this.birth_date, required this.name,});
  factory UserProfile.fromJson(Map<String,dynamic>json){
    return UserProfile(
    name: json['name'],
    email:json['email'],
    mobileNumber:json['mobile_number'], 
    gender:json['gender'], 
    birth_date:DateTime.parse(json['birth_date']),
    image:json['image'],
    country:json['country'], interests: List<String>.from(json['interests'])
   );
  }
}