class User {
  final String image;
  final String firstname;
  final String lastname;
  final String email;

  User({this.image, this.firstname, this.lastname, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'],
        lastname: json['lastname'],
        firstname: json['firstname'],
        image: json['image']);
  }

  Map toMap() {
    var map = {
      'email': this.email,
      'lastname': this.lastname,
      'firstname': this.firstname,
      'image': this.image
    };
    return map;
  }
}
