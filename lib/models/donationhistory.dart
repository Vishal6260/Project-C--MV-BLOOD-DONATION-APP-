class donationhistory {
  donationhistory({
    this.id,
    required this.date,
    required this.userid,
    // this is optional when creating a new user model
  });

  final String? id;
  DateTime date;
  String userid;
}
