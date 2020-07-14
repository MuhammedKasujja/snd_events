
class Event {
  final int id;
  final String startDate;
  final String endDate;
  final String theme;
  final String street;
  final String startTime;
  final String endTime;
  final String photo;
  final String speaker;
  final String locDistrict;
  final String organizer;

  Event(
      {this.id,
      this.startTime,
      this.endTime,
      this.startDate,
      this.endDate,
      this.theme,
      this.street,
      this.photo,
      this.speaker,
      this.locDistrict,
      this.organizer});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      theme: json['theme'],
      photo: json['photo'],
      speaker: json['speaker'],
      locDistrict: json['location_district'],
      organizer: json['organizer'],
      street: json['building_street'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }
}
