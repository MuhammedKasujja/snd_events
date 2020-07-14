
class Child{
   int id;
   String name;
   String gender;
   int age;

  Child({this.id, this.name, this.gender, this.age});

  Child.fromJson(Map<String, dynamic> json){
    this.id = json['id'];
    this.name = json['full_name'];
    this.gender = json['gender'];
    this.age = json['age'];
  }
}