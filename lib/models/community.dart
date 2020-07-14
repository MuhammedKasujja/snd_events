
class Community {
  final String name;
  final String image;
  final String description;
  final List topics;
  final locDistrict;
  final country;

  Community(
      {this.name,
      this.image,
      this.description,
      this.topics,
      this.locDistrict,
      this.country});
  
  factory Community.fromJson(Map<String, dynamic> json){
    return Community(
      name: json['name'],
      image: json['image'],
      description: json['describe'],
      locDistrict: json['location_district'],
      country: json['location_country'],
      topics: json['topics']
    );
  }
}
