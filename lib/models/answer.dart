class Answer {
  final int id;
  final String date;
  final String answeredBy;
  final String userPhoto;
   int approved;

  Answer({this.id, this.date, this.answeredBy, this.userPhoto, this.approved});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
        id: json['id'],
        date: json['date'],
        answeredBy: json['answered_by'],
        userPhoto: json['photo'],
        approved: json['approval']);
  }
}
