class Community {
  String name;
  String image;
  String description;
  List topics;
  String locDistrict;
  String country;
  int id;
  String createdBy;

  Community(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.topics,
      this.locDistrict,
      this.country,
      this.createdBy});

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        description: json['describe'],
        locDistrict: json['location_district'],
        country: json['location_country'],
        topics: json['topics'],
        createdBy: json['created_by']);
  }
}
