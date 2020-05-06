class User {
  String id;
  String fullName;
  String email;
  String rank;
  bool male;
  String serviceBranch;

  User(
      {this.id,
      this.fullName,
      this.email,
      this.rank,
      this.male,
      this.serviceBranch});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fn'],
        email = data['e'],
        rank = data['r'],
        male = data['m'],
        serviceBranch = data['sb'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fn': fullName,
      'e': email,
      'r': rank,
      'm': male,
      'sb': serviceBranch
    };
  }
}
