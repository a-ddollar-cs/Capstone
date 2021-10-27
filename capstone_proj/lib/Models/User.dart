class User {

  //setup bool for owner/renter stuff
  bool owner;
  String bio;

  User(this.bio);

  Map<String, dynamic> toJson() => {
    'bio': bio,
    'owner': owner,
  };


}