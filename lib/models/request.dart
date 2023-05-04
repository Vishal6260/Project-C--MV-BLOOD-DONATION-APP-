class Request {
  Request({
    required this.id,
    this.name,
    this.bloodgroup,
    this.location,
    this.phone,
    this.remarks,
    // this is optional when creating a new user model
  });

  final String id;
  String? name;
  String? bloodgroup;
  String? location;
  String? phone;
  String? remarks;
}
