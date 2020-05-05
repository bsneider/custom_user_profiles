class User {
  final String id;
  final String fullName;
  final String email;
  final String userRole;
  String rank;
  bool male;
  String serviceBranch;

  User(
      {this.id,
      this.fullName,
      this.email,
      this.userRole,
      this.rank,
      this.male,
      this.serviceBranch});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fn'],
        email = data['e'],
        userRole = data['ur'],
        rank = data['r'],
        male = data['m'],
        serviceBranch = data['sb'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fn': fullName,
      'e': email,
      'ur': userRole,
      'r': rank,
      'm': male,
      'sb': serviceBranch
    };
  }
}
