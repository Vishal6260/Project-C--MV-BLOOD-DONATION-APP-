class Myuser {
  Myuser({
    required this.id,
    this.name,
    this.bloodgroup,
    this.location,
    this.email,
    this.phone,
    this.password, // this is optional when creating a new user model
  });

  final String id;
  String? name;
  String? bloodgroup;
  String? location;
  String? email;
  String? phone;
  String? password;
}
