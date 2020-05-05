class User {
  final String id;
  final String fullName;
  final String email;
  final String userRole;
  String rank;

  User({this.id, this.fullName, this.email, this.userRole, this.rank});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fn'],
        email = data['e'],
        userRole = data['ur'],
        rank = data['r'];

  Map<String, dynamic> toJson() {
    return {'id': id, 'fn': fullName, 'e': email, 'ur': userRole, 'r': rank};
  }
}
